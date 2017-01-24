---
title: Functional State Machines in C++
author: silverweed
layout: single
tags:  
  - c++  
  - programming  
  - videogames  
  - lifish  
---

My videogame, [Lifish](https://silverweed.github.io/lifish/), features several boss fights.
Bosses are probably the most complex type of entity found in Lifish, as their behaviour
needs to be interesting and diverse to make the fight engaging.

Most of the bosses' AI is implemented via a finite state machine (FSM) which on every
update decides the state of the boss and thus its behaviour.

Since FSMs are so common in videogame AI, I'm going to show how I'm using them in Lifish, with the main goals of
clarity and modularity rather than sheer execution speed (although the efficiency of the described
solution is far from bad, thanks to some convenient C++11 features). The implementation details will be in C++,
but the general idea is applicable to many other languages, as long as they allow first-class functions in some form.

### State machines 101

A state machine consists in a set of states and a set of transition rules. Our goal is to associate
some *behaviour* to each state, to make our boss able to act (against our players) and react (to some event or 
situation, either internal --like a timer expiring-- or external --like a player approaching the boss).

The most straightforward way to implement a state machine is to define:  
1. an enumeration of all possible states (typically using an `enum`)  
2. an action associated to every state (like a function or a method) and  
3. a mechanism to select the correct action, given the state (usually done via a `switch` statement).

Let's see how this translates to code.

A sample set of states may be:

```c++
class MyBoss {

	enum class State {
		IDLE,
		ATTACKING,
		DYING
	};

	// ...
```

and we may define methods associated with them:

```c++
	void _updateIdle();
	void _updateAttacking();
	void _updateDying();
```

Then, in the `update()` method of the Boss entity (more on that
[in this post](https://silverweed.github.io/Composition_over_Inheritance-_lessons_learned/))
we just switch over the states and call the corresponding action:

```c++
void MyBoss::update() {
	switch (state) {
	case State::IDLE:
		_updateIdle();
		break;
	case State::ATTACKING:
		_updateAttacking();
		break;
	case State::DYING:
		_updateDying();
		break;
	}
}
```

In this design, state transitions are handled by the action methods in an imperative fashion, like this:

```c++
void MyBoss::_updateIdle() {
	if (attackClock->getElapsedTime() > TIME_BETWEEN_ATTACKS) {
		state = State::ATTACKING;
	}
}
```

This way of implementing FSMs is simple, straightforward and works reasonably in most cases. In fact,
it's how things worked in Lifish until a few weeks ago, when I decided to switch to a different design.

My choice was mostly driven by personal taste, as AFAIK the alternative implementation that
I'm going to describe has no universally objective benefits over this one. I just find it more elegant and
maintainable than the "straightforward one" as it's less imperative and more functional, which is a thing I like.

Let's explore this alternative.

### The "functional" approach

**Disclaimer:** the solution I'm going to describe is by no means new or original. It's used, for example,
[in the Go lexer](https://golang.org/src/text/template/parse/lex.go#L228) and I came to know it thanks to
[a good friend of mine](https://empijei.science/). Also kudos to [another good friend of mine](https://github.com/bluehood)
who helped me a lot with the C++ implementation quirks.

The idea is to drop the explicit states enumeration and keep the internal state implicitly by defining a
"state function". The state function works both as a state and as the action associated with it and it even
contains its transition ruleset internally.

How does this work?

The peculiarity of the state function is that it returns...a state function. In other words, we define it
recursively with the following signature:

```c++
using StateFunction = std::function<StateFunction()>;
```

...or we would, if C++ allowed it. Unfortunately, the language does not allow defining a type in terms of
itself (this is a semantic limitation of C++: Go, for example, permits a definition like 
`type StateFunction func() StateFunction`).

We can work around this problem easily, as we'll see in a moment. For now, just picture the state function as a function
which returns another state function.

With that out of the way, we can now encode our states/behaviours by defining the following methods in our boss class:

```c++
class MyBoss {

	// All possible states
	StateFunction _updateIdle();
	StateFunction _updateAttacking();
	StateFunction _updateDying();

	// Current state function, referring to one of the above methods.
	StateFunction stateFunction = // first state;

	// ...
```

Notice we just changed the return type from `void` to `StateFunction` and added a variable `stateFunction`
to keep the current state.
The bodies of all functions remain unchanged, except for one thing: wherever we have an assignment 
`state = ...` we replace it with a `return newState`, where `newState` is one of our predefined state functions.
In all branches where we *didn't* change the internal state, we just return the current state function.

So, ideally, the `_updateIdle()` method shown above would become something like:

```c++
void MyBoss::_updateIdle() {
	if (attackClock->getElapsedTime() > TIME_BETWEEN_ATTACKS) {
		return _updateAttacking;
	}
	return stateFunction;
}
```

Finally, my favourite bit: in the `update()` method we get rid of the `switch` statement and replace it with:

```c++
void MyBoss::update() {
	stateFunction = stateFunction();
}
```

Ain't it neat? We simply *call* the current state function and immediately reassign it to the one returned
by the state function itself. As you can see, the `update` method is now trivial, and all the behaviour selection
and transition logic is now fully encoded in the very state functions, with no external glue needed.

### Making it actually work

The code above is not working yet. It's almost there, but we need some patches here and there to make the
compiler happy.

The first thing we disregarded is that we can't just return a method: we need to return a *function*.
To do that, we must bind the method to the current instance of `MyBoss`:

```c++
	// Change this:
	// return _updateAttacking;

	// To this:
	return std::bind(&MyBoss::_updateAttacking, this);
```

Then, we haven't defined the StateFunction yet.
The way we do that is by defining a *functor struct*, which is just a normal
struct that overloads the `operator()`. On a first glance, it looks like this:

```c++
struct StateFunction {
	template <typename T>
	StateFunction(const T& f) : f(f) {}

	StateFunction operator()() {
		return f();
	}

	std::function<StateFunction()> f;
};
```

As you can see, we implement the "recursive definition trick" by defining an internal member `f` as a function that
returns a `StateFunction`. The constructor accepts a generic function type `T` that is used to copy-construct `f`.

We aren't done yet. We need a way to create a StateFunction out of another StateFunction to enable the state updating
described above.

Remember that the state function swapping needs to happen on *every* update. We don't want to pay the cost of
copy-constructing a new `StateFunction` every time, as the `StateFunction` struct should just be a thin wrapper to
a function reference that gets called once, then forgotten.

Fortunately, C++11 allows us to ensure we don't perform useless copies during the `stateFunction = stateFunction()`
operation by defining a *move assignment operator*:

```c++
	StateFunction& operator=(StateFunction&& s) {
		f = std::move(s.f);
		return *this;
	}
	// Optional: this strictly prohibits copy-assigning a StateFunction.
	// Useful to avoid programming oversights that may inhibit the call 
	// to the move assignment operator.
	StateFunction& operator=(const StateFunction&) = delete;
```

We'll also need a move constructor:

```c++
	StateFunction(StateFunction&&) = default;
	// For good measure
	StateFunction(const StateFunction&) = delete;
```

Finally, whenever we return the unchanged state function, we write:

```c++
	// Change this:
	// return stateFunction;
	
	// to this:
	return std::move(stateFunction);
```

where we use `std::move` to tell the compiler to enable move-constructing the return value rather than copying it.


### Summing up

That was a bit of code, wasn't it? To sum it up, we can isolate the StateFunction definition in its own header file:

```c++
// StateFunction.hpp
#pragma once

#include <functional> // for std::function
#include <utility>    // for std::move

struct StateFunction {
	template <typename T>
	StateFunction(const T& f) : f(f) {}
	StateFunction(StateFunction&& s) = default;
	StateFunction(const StateFunction& s) = delete;
	StateFunction operator()() {
		return f();
	}
	StateFunction& operator=(StateFunction&& s) {
		f = std::move(s.f);
		return *this;
	}
	StateFunction& operator=(const StateFunction&) = delete;
	operator bool() const { return bool(f); }
	std::function<StateFunction()> f;
};
```

This general-purpose state function can now be used wherever an FSM is desired. The way we defined it forces
the programmer to make an efficient use of the StateFunction struct by forbidding copy operations, so the
final result won't perform significantly worse than the classic enum/switch solution.

A bonus of this design is that I don't need to bother editing an enum every time I add or remove a state to the FSM.

---
This way of dealing with FSMs is currently my favourite. It's slightly more complex to get in the beginning than the
enum/switch one, but it feels more refined. Maybe in the future I'll find even better solutions, who knows.
In the meantime, I encourage you to try it: it's definitely worth the try!

As usual, thanks for reading :-)
