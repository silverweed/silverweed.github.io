---
title: "Rust game programming: data hotloading"
author: silverweed
layout: single
tags:  
  - videogames  
  - rust  
  - programming
---

I've been fiddling around with [Rust](https://www.rust-lang.org) for some months now, with the intent of learning more about both Rust itself and game/engine programming. The result is a tiny -- but slowly growing -- project for an [unnamed game / engine](https://github.com/silverweed/ecsde) I'm working on during my spare time.

My current goals with this project are to use it as a testing ground for various ideas, taking all the time I want, but with the idea of eventually having something playable.

One of the first experiments I wanted to try, that [my previous project](https://github.com/silverweed/lifish) completely lacked, is hot-reloading of data and code. In a nutshell, this means to enable changing game data and logic while the game runs and have the game use that new data or logic without the need to restart.

## Data hotloading
The first step I took was implementing data hot-reloading, because it looked quite straightforward to do.
Here are the steps I took for that:

1. define a simple format for defining "configuration data", i.e. hot-reloadable variables;
2. define a data structure in the code to interface with the configuration data;
3. parse all configuration files during startup;
4. spawn a thread to watch for changes in the configuration files, and re-parse any of those files upon change.

Let's go over all the steps in more detail.

### File format
In my previous game, I used Json for all data files, both for configuration and serialization. For this project I wanted something more convenient. 

Json is pretty human-readable and writable, but a) it's both too complicated for my purpose, b) it typically requires an external library to parse and c) it's not the most configuration-friendly format out there.

So i just went with my own file format, which is a very simple ini-like one:

```
# this is a comment
/this/is/a/header
this_is_a_key 42 # the '42' is the value
```

Cannot get much simpler than that. Headers are there just to categorize the different configuration variables and to keep them in a tidy orderly fashion.

Currently I only support five types for keys: bool, int, uint, float and string, and I don't plan to add more for now. Because the format is so simple, writing a parser for it is trivial, and the format can always be changed later in case of need.

### Code interface
On the code side, I defined a data structure `Cfg_Var<T>` designed to hold a configuration value (`T` can only be of type `bool`, `i32`, `u32`, `f32` or `String`). I had two requirements in mind when designing this struct and its interface:

1. it should be almost as easy to use as it'd be to just use the plain value it holds;
2. it should in fact become just its contained value when building the game in release mode.

Because of these requirements, the `Cfg_Var` definition is different in debug and release mode:

- in **debug** mode, the struct is basically a "pointer" into a "configuration variables table", which holds all the current config values;
- in **release** mode, the struct is a simple wrapper to its value.

The "configuration variables table" mentioned above is just a hash table that maps key names to their values and, in debug mode only, it can be updated at runtime whenever a config file is edited.

The way you read values out of `Cfg_Var` is the same in both debug and release mode, and is done by calling a `read` method on it, with the following signature:

```rust
impl<T> Cfg_Var<T> {
    pub fn read(&self, cfg: &Config) -> T { /* ... */ }
}
```

The `Config` struct is where the configuration table is stored. Although inconvenient, it must be passed to `read` every time you want to read a `Cfg_Var`; this is the solution I came up with to avoid defining it as a global variable, which would be very bad as soon as we'd try to implement *code* hotloading (more on that in a future post :-).
Being quite new to Rust, I'm not sure this is the best solution one could find to this problem, but it's good enough for me at this time, so I decided to go with it.

Let's now look more closely to the `Cfg_Var` definitions:

```rust
// This is used in debug mode
#[cfg(debug_assertions)]
pub struct Cfg_Var<T> {
    id: String_Id,
    _marker: PhantomData<T>, // ignore this, it's just needed as a compiler hint
}

// This is used in release mode
#[cfg(not(debug_assertions))]
pub struct Cfg_Var<T>(T); // this denotes a tuple with a single element of type T
```

In debug mode, the `Cfg_Var` contains a `String_Id` (i.e. an integer resulting from hashing a string), which is used in the `read` method to lookup the current config value in the table; in release mode, the config table isn't read at all: the method just returns `self.0` -- the wrapped value.

An example usage of this is the following:

```rust
// Create the Config struct (once in the entire app)
let mut cfg = Config::new_from_dir(CFG_DIR);

// Create the config variable (once in the entire app)
let sleep_time_ms = Cfg_Var::new::<f32>("/engine/sleep_time_ms", &mut cfg);

loop {
    std::thread::sleep(sleep_time_ms.read(&cfg)); // use the value (updated live in debug mode)
}
```

The nice thing of this setup is that, in release mode, there is no overhead in calling `read` -- at least for types that are trivially copyable -- and in debug mode we get the convenience of values updated live without restarting the game.

### Implementing variadic types for Cfg\_Var
As mentioned above, the configuration variable table is a hash map which maps the config variables' names with their value.
While the table's key type is `String_Id`, you may be wondering what is the *value* type. After all, a config variable can contain a bool, an integer, a float or a string.

In C++ one would probably use a `union` to contain that value. In Rust, a more convenient (and type-safe) solution is to use an enum.
Rust enums can contain data, so our variadic config value can be expressed like this:

```rust
pub enum Cfg_Value {
    Bool(bool),
    Int(i32),
    UInt(u32),
    Float(f32),
    String(String),
}
```

We can store this type in the hash map and query it when we read it, ensuring the type we're looking for matches the one stored in the table:

```rust
// Conceptually, like this:
impl Cfg_Var<bool> {
    pub fn read(self, cfg: &Config) -> bool {
        let key = self.id; // The String_Id with the config variable name
        // Ensure the hashmap contains our key
        let value = cfg.table.get(&key).expect("Value not found in the table!");
        // Ensure the type is the one we expect
        match value {
            Bool(val) => val,
            // (probably this failure should be handled more gracefully)
            _ => panic!("Unexpected value {:?}!", value)
        }
    }
}

// ... Implement the other specializations of Cfg_Var ...
```

### Watching file changes
The last missing step is to do the actual hot reloading. I used the crate [notify](https://docs.rs/notify/5.0.0-pre.1/notify/), which allows me to easily
watch a specific directory and receive events every time a file is modified inside it.

On startup, in debug mode only, the engine spins up a thread running an infinite loop waiting for `notify` events:

```rust
pub fn start_file_watch(
    path: PathBuf,
    event_handlers: Vec<Box<dyn File_Watcher_Event_Handler>>,
) -> io::Result<JoinHandle<()>> {
    thread::Builder::new()
        .name(format!("fwch_{:?}", path.as_path().file_name().unwrap()))
        .spawn(move || {
            file_watch_listen(path, event_handlers).unwrap();
        })
}
```

Here, `event_handlers` is an array containing any number of pointers to `File_Watcher_Event_Handler`s, which is a
custom trait simply defined as:

```rust
// (Note: `Send` because we want to send it to different threads)
pub trait File_Watcher_Event_Handler: Send {
    fn handle(&mut self, evt: &DebouncedEvent);
}
```

This way I can handle any `notify` event multiple times in any way I want. The `file_watch_listen` routine is really nothing fancy:

```rust
fn file_watch_listen(/* ... */) {
    // Build a channel through which `notify` will send us events
    let (tx, rx) = channel();
    // Start watching
    let mut watcher = notify::watcher(tx, watch_interval).unwrap();
    watcher.watch(path.to_str().unwrap(), RecursiveMode::Recursive)?;

    loop {
        notify_handlers(&mut event_handlers, rx.recv()?);
    }
}

// This just iterates over all event_handlers and sends them the event.
fn notify_handlers(
    event_handlers: &mut [Box<dyn File_Watcher_Event_Handler>],
    event: DebouncedEvent,
) {
    for handler in event_handlers.iter_mut() {
        handler.handle(&event);
    }
}
```

The very last step is to implement a `File_Watcher_Event_Handler` which reloads the config data when needed:

```rust
pub struct Config_Watch_Handler { 
    // Note: we create this struct so that sending data through 
    // this channel tells our `Config` struct to 
    // update an entry in its table.
    config_change: Sender<Cfg_Entry> 
}
    
impl file_watcher::File_Watcher_Event_Handler for Config_Watch_Handler {
    fn handle(&mut self, event: &DebouncedEvent) {
        match event {
            DebouncedEvent::Write(ref pathbuf) | DebouncedEvent::Create(ref pathbuf)
                if !utils::is_hidden(pathbuf) =>
            {
                // ... Parse `pathbuf` into an array of Cfg_Entry ...

                // Send the updated entries to Config
                for entry in entries.into_iter() {
                    self.config_change.send(entry).unwrap();
                }
            }
            _ => (),
        }
    }
}
```

---

If you've read this far, thank you!

This is the longest post I've written in a while and I hope I managed to keep it intelligible enough.
Keeping a balance between the amount of code and explanations is not my forte and I hope future posts will
do a better job at it. If you want clarifications and/or have comments about anything I wrote, please don't hesitate to
write a comment below this post.

Until next time! :-)
