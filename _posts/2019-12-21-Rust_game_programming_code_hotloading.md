---
title: 'Rust game programming: code hotloading'
author: silverweed
layout: single
tags:
  - videogames  
  - rust  
  - programming
---

In [my previous post](/Rust_game_programming_hotloading/) I talked about data hot-reloading and its implementation inside my game engine.
Today it's time to tackle *code* hot-reloading, i.e. the possibility to change the game code, recompile it and see the results without having to
quit and restart the program.

This is especially desirable while iterating a feature over and over, where the *write -> compile -> restart* cycle
would start to become particularly time-expensive over many iterations. Removing the *restart* part from the cycle results in lower (and
more enjoyable) iteration times.

It turns out this is easy on one hand, while on the other it dictates a specific commitment over the entire codebase design, thus it's a choice
better taken early. Luckily, this design constraint happens to be the same that the Rust language strongly favours: *give up on global state entirely*.

Before going into the details, I'd like to remark that the strategy I used is not at all an invention of mine: I took most of it from
[this 2014 post by Chris Wellons](https://nullprogram.com/blog/2014/12/23/) who in turn took inspiration by the excellent [Handmade Hero series by
Casey Muratori](https://handmadehero.org/). Let's see how code hotloading (or 'interactive programming') is done in Rust.

### Code hotloading
Broadly speaking, reloading a piece of code while running the game is not much different from reloading some configuration data: you watch a certain
file for modifications and, upon any change, you load that file and discard the data from the old one. 
The difference is that, this time, the file in question is not a data file but a *dynamic library* (aka "shared object"), and instead of fetching
data from it we want to fetch exported symbols (i.e. functions and structs).

The key idea that makes this possible is that we split our program into two main pieces: the *game* itself and a *game runner*.
The game itself will be compiled as a dynamic library exporting a specific set of functions, while the game runner's job will 
be just to load the game, fetch those exported functions and run them. In addition, in debug mode only, the runner will watch for 
changes in the game library file and reload it, effectively changing the program code at runtime.

### What are we going to reload, exactly?
It's important to understand that the method I'm going to describe is not entirely replacing quitting and restarting the whole game (unless
done *very* thoroughly - more on that later). Remember the "specific set of functions" exported by the game library that I mentioned earlier?
Those are called the "Game API" and correspond to the broad phases of the lifetime of our game. Broadly speaking, the game needs to:  
   1. Start
   2. Update
   3. Unload<span style='color: red'>\*</span>
   4. Reload<span style='color: red'>\*</span>
   5. Shutdown

where the points marked with <span style='color: red'>\*</span> are only needed in debug mode (as they're part of the hotloading process). For each of these phases, there
is a corresponding exported function that the game runner is able to call. These are also the functions that get reloaded every time
the game library file changes (i.e. every time we recompile the game).

The game runner starts by loading the game library, calling the *Start* function, then enters the game loop where it continuously calls
*Update* until it's told to stop. When the runner discovers that the game library must be reloaded, it calls *Unload*,
reloads the library with all its symbols and then calls the (freshly loaded) *Reload* function. *Shutdown* is only called
once, when the game loop is exited.

Notice that, even when we reload the game library, the *Start* function is not called anymore, so we won't go through all the initialization
process a second time. This means that either:  
   * we simulate the shutdown/start process in the *Unload* and *Reload* functions, or
   * we just support hotloading the *Update* part of the game.

In my game, I'm currently going for the second path, which is by far the simplest. The *Update* part is the best candidate for hotloading when iterating over a new feature
anyway, so if I'm going to change something going on on start I just shutdown and restart the whole game - which I'd probably do
in any case, to be sure it's actually working.

### Global state, or lack thereof
To make this process work, a crucial element is that the game *must not have any (mutable) global state*. If that was the case, the global pointers
would become invalid across library reloading, and the game would simply crash.

This means that we must design *all* our game so that it always passes its state around in the form of function parameters. No `static` variables allowed.
This happens to be the pattern that Rust likes the best, so it's a win-win situation for a game written in Rust.

In practice, this translates to defining an all-enclosing `Game_State` struct containing all game systems and data, and passing its fields around
to the internal systems. The struct itself is then used to communicate across the game and the runner, as we'll see in a moment.

### All nice and dandy, but how do I implement it?
The first step to take, as mentioned earlier, is to split off the program into multiple sub-programs - in the case of Rust, multiple *crates*.
In my project I have a total of 3 crates:
```
root
├── engine  (static library - crate_type = "lib")
├── game    (dynamic library - crate_type = "cdylib")
└── runner  (executable - crate_type = "bin")
```

The `engine`/`game` split is not strictly necessary, but I find it useful to have a clear division between the engine services and the
game features using them. The engine part is compiled as a static library and linked together with the game in the dynamic game library.

Inside each directory, `root` included, there is a `Cargo.toml` file specifying how the crate is built. In the case of the `root` directory,
this file contains the lines:

```toml
[workspace]
members = ["engine", "game", "runner"]
```

which tells `cargo` to treat all 3 crates as members of the same [workspace](https://doc.rust-lang.org/book/ch14-03-cargo-workspaces.html) (I wish
I discovered this Cargo feature earlier: if it's the first time you hear it, no need to thank me ;-)

**NOTE:** when using a workspace, be sure to set the `game` crate type to `cdylib`, not `dylib`. Else, the code hotloading will make the program
crash due to different dll linking performed by `cargo`.

### Exporting the game API
The next step is to make the `game` crate export its public API to the runner. To do this, you need to define a common set of functions agreed upon
by both `game` and `runner`; something like this:

```rust
// runner/src/game_api.rs

use libloading as ll;

// Note: this is an opaque type
#[repr(C)]
pub struct Game_State {
    _private: [u8; 0],
}

pub struct Game_Api<'lib> {
    /// Called on game start
    pub init: ll::Symbol<'lib, fn() -> *mut Game_State>,

    /// Called every game loop. Returns `false` if the game should terminate.
    pub update: ll::Symbol<'lib, fn(*mut Game_State) -> bool>,

    /// Called when game exits
    pub shutdown: ll::Symbol<'lib, fn(*mut Game_State)>,

    /// Called every time the game library is unloaded (debug mode only)
    pub unload: ll::Symbol<'lib, fn(*mut Game_State)>,

    /// Called every time the game library is reloaded (debug mode only)
    pub reload: ll::Symbol<'lib, fn(*mut Game_State)>,
}
```

These functions are defined as library symbols containing functions inside the `runner`. There are two things to notice here:  
   1. every function either returns or accepts a mutable raw pointer to `Game_State`. This is the one and only way we ever
      communicate with the game from the runner;   
   2. the `Game_State` itself is an *opaque* struct, i.e. the runner needs not know anything about the specific content
      of the game state. It only every deals with a pointer to it, never with its internal fields. This is very convenient,
      as it means we can restructure the actual `Game_State` struct on the `game` side without ever changing the `runner`.
      (The `_private: [u8; 0]` field is the current way to tell Rust that this is an opaque struct.)

On the other end, inside the `game` crate, we need to actually define those exported functions and the `Game_State`:

```rust
// game/src/lib.rs

#[repr(C)]
pub struct Game_State<'a> {
   // ... lots of fields
}

// Note: the lifetime is actually ignored. 
// The Game_State's lifetime is manually managed.
#[no_mangle]
pub extern "C" fn game_init<'a>() -> *mut Game_State<'a> {
    /// Something conceptually like this:

    // Create the game state
    let game_state: Game_State = internal_create_game_state();

    // Turn game_state into a manually-managed pointer
    Box::into_raw(Box::new(game_state))
}

#[no_mangle]
pub unsafe extern "C" fn game_update(game_state: *mut Game_State) -> bool {
    if game_state.is_null() {
        panic!("[ FATAL ] game_update: game state is null!");
    }

    let game_state = &mut *game_state;
    internal_game_update(game_state)
}

// ... reload and unload (both may do nothing at all) ...

#[no_mangle]
pub unsafe extern "C" fn game_shutdown(game_state: *mut Game_State) {
    // ... check null ...

    // Destroy the game_state
    std::ptr::drop_in_place(game_state);
    // Free its backing memory
    std::alloc::dealloc(game_state as *mut u8, Layout::new::<Game_State>());
}
```

### Running the game loop
With all this machinery set up, the game runner merely needs to call the appropriate functions at the right time.

```rust
// Note: this is almost pseudo-code, just to highlight the important parts.
fn main() {
    // Load the game library and its symbols
    // (I'm using the `libloading` crate for that)
    let mut game_lib = lib_load(GAME_DLL_PATH);
    let mut game_api = unsafe { game_load(&game_lib) };
    
    // Start the game
    let game_state = unsafe { (game_api.init)() };

    // Game loop
    loop {
        // Process library hot-reloading if needed
        if lib_reload_pending() {
            unsafe {
                (game_api.unload)(game_state);
            }
            // Load the new library and symbols
            game_lib = lib_reload(GAME_DLL_PATH);
            unsafe {
                game_api = game_load(&game_lib);
                // Note that game_state didn't change across reload! 
                // We're keeping the game alive and running.
                (game_api.reload)(game_state);
            }
        }

        // Do the actual game update
        unsafe {
            if !(game_api.update)(game_state) {
                break;
            }
        }
    }

    unsafe {
        (game_api.shutdown)(game_state);
    }
}
```

#### DLL reloading quirks
In an ideal world, the code above would basically be the entire job of `runner`. Unfortunately, convincing the OS to actually
reload the game library is not as straightforward as one would think. On Linux, simply calling `dlopen()` multiple times
on the same file gets the job done, no strings attached. On Windows, the equivalent doesn't seem to work unless the newly loaded
library has a *different name* than the one already loaded.

For this reason, the `lib_load` and `lib_reload` functions listed above must perform the additional task of renaming the
game library every time it is loaded, to ensure the OS will actually load the new one. I won't show the complete code here
because it's pretty trivial (`std::fs` is your friend), just know you'll need to do it to support hot-reloading on Windows
(and maybe OSX too).

---
We can finally admire the result of our work! (I'm running [cargo watch](https://github.com/passcod/cargo-watch) in the background, otherwise you need to manually recompile after you make the changes)

<figure>
  <a href='/assets/video/ecs/hotloading_code.webm'>
    <video style='width: 100%' src='/assets/video/ecs/hotloading_code.webm' alt='Hotloading Code' loop muted preload autoplay>
      Your browser does not support HTML5.
    </video>
  </a>
</figure>

As always, thanks for reading this far. Until next time :-)
