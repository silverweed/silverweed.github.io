---
title: Dynamic component querying in Lifish
author: silverweed
layout: single
tags:  
  - programming  
  - videogames  
  - c++
---

In the [previous post](/Composition_over_Inheritance-_lessons_learned/) I talked about Entity/Component
architecture in Lifish, the approach being:  

* **Entity**: contains Components and optionally some Entity-specific code  
* **Component**: contains Entity-agnostic code (and optionally other Components).

In this post, I'll delve into some implementation details of this architecture. Decent knowledge of C++ (preferably at least C++11)
is recommended in order to better understand this article, but is not strictly required.

So, since an Entity is a bag of Components, the basic operations it needs to support are adding and retreiving them.
But even before this, we need to decide how to store components in an Entity. The requirements are the following:

1. we want to iterate easily over Components to update them during each game loop;  
2. we want to quickly retreive any Component by its class. I say "class" and not "index", "tag" or whatever for the following reason:  
3. we don't know *a priori* the totality of Components we'll have in our game, and we want to be able to add them easily
   without having to bother on adding an entry to an enum or manually assign an index to a specific Component type.
   This'll become clearer in a moment.  
4. we want a type-safe solution.

What does point 3 mean? Basically, a very easy solution to the first two problems would be creating a dictionary
whose key is the "unique index" of a Component class and the value is the Component (or a list of Components, as we'll see):
in this way the Component retreival would be ~O(1) and we could just iterate over the keys to fullfil requirement 1.

Our goal is to have something like this:

```c++
class Entity {
	using ComponentType = // some convenient pointer type to a Component.
	                      // For now, think of Component*.
	using ComponentList = // some convenient container of Components.

	dictionary<UniqueIndex, ComponentList> components;

	template<class T>
	ComponentType getComponent() { 
		// retreive the first component of type T found 
	}

	void addComponent(ComponentType component) { 
		// adds the component 
	}
};
```

So we have the following problems:

1. choose a good `ComponentType` to pass Components around;  
2. choose a good `ComponentList` type for storing Components;  
3. choose a good `UniqueIndex` type to use as a key for internally retreiving Components.

Let's go through these issues.

## ComponentType?

C++ is not like Java or C#, where you just always pass around "references" (more like restyled pointers) to objects. You've got
to know very precisely who *owns* some object, what its *lifetime* is and how other parts of the code can *access* it.

The owner of a Component seems obvious: it's the Entity which contains it, right? Well, yes...and no. I mean, that is
clearly the case, but it just so happens that it's sometimes convenient to allow other objects to manage another Entity's
Component for a while, to avoid continuously querying it. That is for example the case of the Collision manager:
it needs to handle Entities' Collider Components all the time, and it'd be ugly and inefficient if it had to `get`
all those colliders every loop.

This means a good choice for the `ComponentType` is a `std::shared_ptr<Component>`.

A `shared_ptr` will keep the wrapped Component alive as long as at least one reference to it exists, and it
enables using `weak_ptr` to monitor its state externally. This makes the ownership model very explicit.

The lifetime is also reasonably accounted for, as long as we don't retaing strong ownership over stuff we don't own.
If we limit ourselves to use weak pointers to access Components from outside their owner, all the Components of an
Entity will be promptly destroyed as soon as said Entity is. Nice.

So we properly solved the ownership, lifetime and access problems in relation to the Components retreival.

What about adding them?

`addComponent` can also accept a `shared_ptr`, which is useful when you create a Component outside of the Entity and
then add it, but it actually has a second signature which is much nicer:

```c++
template<class T, class... Args>
T* addComponent(Args&&... args);
```

This overload is used in the most common case, where you create and add the Component at the same time, and it looks
like this:

```c++
// e.g. within the Entity's constructor
addComponent<Damageable>(*this, 10);
```

the given parameters are forwarded to `Damageable`'s constructor via what is called *perfect forwarding*. I suggest
you look it up if you're into C++, because it's a cool, clean way to pass around parameters through proxy functions,
leveraging C++'s metaprogramming features.

## ComponentList?

We sometimes need to add more than 1 instance of a certain Component type to an Entity, so our Components container
needs to support this.

In Lifish, what I do is the following:

* by default, every Component class can be only added once to an Entity, and an exception is raised when two Components
  of the same class are added to the same Entity.  
* if a Component class may be added more than once, it must declare it inside its class definition via a macro;  
* the Entity class actually contains several `getComponent` methods, according to the need:  
  1. `T* get<T>()` returns a raw pointer to the first Component of type `T` found;  
  2. `shared_ptr<T> getShared<T>()` is like `get` but returns a shared pointer;  
  3. `vector<shared_ptr<T>> getAllShared<T>()` returns all Components of type `T`;  
  4. et cetera.

Note that it's perfectly fine to return and pass around a raw pointer, as long as whoever receives it does not retain
it for more than 1 game loop, as it may become invalid if its owner is destroyed.

Not much more to say about this: in the end, I use a `std::vector<Component>` as container type for components of the
same class. `std::vector` is an excellent default whenever you need fast iteration and random access.
As in Lifish Components cannot be removed, only added, there are no memory relocation downsides as well.

## Unique index?

This is a non-trivial problem. The choice of the key for the internal components' dictionary has potential implications on
both the game performance and the API convenience.
The solutions that came to my mind when first approaching this issue were either a) use an integer, or b) use a string.

### Using integer indices

The integer approach involves creating an enum containing all the Component classes. E.g. suppose
we have a `Damageable` and a `Moveable` Components: the enum would then be:

```c++
enum ComponentType {
	DAMAGEABLE,
	MOVEABLE,
	N_COMPONENTS
};
```

and the Components dictionary may just be a plain array at this point, with all the nice speed improvement this brings:

```c++
class Entity {
	// Something like this
	std::array<ComponentList, ComponentType::N_COMPONENTS> components;
};
```

The huge problem with this approach is that it requires to manually keep in sync the enum and your actual classes.
Every time you add, remove or rename a Component you need to update the enum accordingly. Not to mention the hassle
of handling Components with the same name which may exist in different namespaces.

Of course you can automate the process of creating the enum, but in my opinion this is a pretty ugly solution, and
may be resorted to only in case of concrete need for optimization.


### Using string keys

The string approach goes as follows: you implement a static method `getType()` (or something like that) in the
base Component class, override (or rather, shadow) it in the children,
then use that as an unique identifier for a Component class.

```c++
class Component {
	static std::string getType() { throw "Not implemented"; }
};

class Damageable {
	static std::string getType() { return "Damageable"; }
};
```

And in the Entity:

```c++
class Entity {
	std::unordered_map<std::string, ComponentList> components;
};
```

This approach looks pretty ugly too.
First of all, we're kinda mocking polymorphism on static methods (which cannot be declared `virtual`) and using a
pretty heavy-weight type as a key with no real benefit. Furthermore, the problem of having Components with the same name in different
namespaces is not solved, unless we go all-in and fully qualify the returned strings:

```c++
// Looking uglier and uglier
static std::string getType() { return "lif::Damageable"; }
```

Also, we still have a lot of manual work to do, as for every Component we implement we need to write its `getType`
method.

### Final decision

In the end I decided to adopt a solution which doesn't require to manually write strings or enums, but only needs
the programmer to add one line to the implementation of a Component, which can be done automatically with a script.

C++ offers a "reflection" facility known as `typeid`. `typeid` is an operator that, when applied to a type or an
expression, returns information about it (as a `std::type_info` object). This can be used, for example, to obtain
a type's (mangled) name as a string: `cout << typeid(1 + 1).name() << endl;`

While `type_info` is quite inconvenient to handle (e.g. it can't be stored in a variable as it's neither CopyConstructible
nor CopyAssignable), there is a wrapper that makes it usable: `std::type_index`. This is a much nicer type, which is
guaranteed to be unique for each type, can be compared to other `type_index`es and is also hasheable.
So, I use `std::type_index` as the key type.

There is a last catch though: I want to be able to `get` a Component by class, even if it's a subtype of the class
I'm querying:

```c++
class Moving : Component { /*...*/ };
class AxisMoving : Moving { /*...*/ };

auto am = make_shared<AxisMoving>();
entity.addComponent(am);
entity.get<Moving>(); // -> I want to get `am` back
```

To achieve this, every Component keeps a *stack* of keys, rather than only one,
and each Component's constructor as its first operation adds the key relative to its class to that stack, like this:

```c++
// Component.hpp
class Component {
protected:
	using CompKey = std::type_index;

	std::vector<CompKey> keys;

	template<class T>
	void _declComponent() { keys.emplace_back(_getKey<T>()); }

	template<class T>
	std::type_index _getKey() const {
		return std::type_index(typeid(T));
	}
};

// Moving.cpp
Moving::Moving() {
	_declComponent<Moving>();
	// rest of the constructor code...
}
```

and the `add` and `get` method use this fact:

```c++
template<class T, class... Args>
T* Entity::addComponent(Args&&... args) {
	// Create the component and perfect-forward the given args to it
	auto comp = std::make_shared<T>(std::forward<Args>(args)...);
	// For each key in the component's key stack, add this component to
	// the list of components corresponding to that key
	for (const auto& t : comp->getKeys())
		components[t].emplace_back(comp);
	return comp.get();
}

template<class T>
std::shared_ptr<T> Entity::getShared() const {
	// Check if we have at least 1 Component which has the key relative to
	// class T in its key stack
	auto comp = components.find(_getKey<T>());
	if (comp == components.end() || comp->second.size() == 0)
		return std::shared_ptr<T>(); // no component found
	// Found: return the first component of the list.
	return std::static_pointer_cast<T>(comp->second[0]);
}
```

In the end, there is quite a lot under the hood of `Entity` and `Component` classes, but the resulting visible
API is quite clean and nice. As long as every Component calls `_declComponent` in their constructor, the dynamic
Component retreival from an Entity just works, and thanks to the templated `get` method, the returned Component
is already cast to the correct type.

Feel free to [explore the actual code](https://github.com/silverweed/lifish/blob/master/src/core/Entity.hpp)
for the details I've omitted here for sake of brevity. If you'd like any aspect to be explored in more detail, please
let me know and I'll see what I can do :-)
