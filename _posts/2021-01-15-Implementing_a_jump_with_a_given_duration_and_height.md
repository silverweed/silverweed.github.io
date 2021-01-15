---
title: Implementing a jump with a given duration and height
author: silverweed
layout: single
tags:  
  - programming  
  - videogames  
---

**DISCLAIMER**: sorry for the ugly formulas, I'll work on integrating LaTeX to my blog and update this post to make them look better.

This will be an oddly specific blog post, but I hope it can be of use to someone.

Some time ago, a friend of mine asked me for a little help on a gamedev problem; it was one of those problems that look super easy at first, then hard and then easy again once you solved it.
The problem was this: *given a "kinematic" character, how do I make it jump such that it will reach height H and land in time T?*

This is slightly different from the usual approach of character movement, where usually one defines the jump force (or velocity) and the gravity affecting the character. Here we want to *derive* those variables from our own conditions: the jump must last exactly *T* seconds and reach a height of exactly *H*. (Where "exactly" here actually means "must be as close as possible to").

This problem looks easy at a first glance. One may think: "I'll just use the law of kinematic motion":

```
y(t) = y0 + v0 * t + 1/2 g t^2
```

"and solve for `t = T/2` and put `y(T/2) = H`!"

However, this is not gonna work because that equation is valid only if *t* is the *independent* variable, *y* the *dependent* variable and *y0*, *v0* and *g* are given parameters.

In our case, the given parameters are *H* and *T*. The proper way to approach this problem is not starting from the already-derived equation of motion, but from its parent: the differential equation *y'' = a*. Then, all we need to do is adding the boundary conditions that encode our requirements and solve it.

The first boundary condition is the fact that we are starting the jump from ground level (we may actually be starting from any height, but all we want from our jump is that it requires time *T* to be back to the starting height, so we can just set our reference frame so that the starting height is y = 0):

```
y(t = 0) = 0    // (1)
```

Second, we want to be back to the ground level at time *T*:

```
y(t = T) = 0    // (2)
```

The system consisting of the differential equation `y''(t) = a`, (1) and (2) gives us a family of parabulas as its solution:

```
y(t) = a/2 t^2 + b t + c

// (1) => c = 0
y(t) = a/2 t^2 + b t

// (2) => a/2 T^2 + b T = 0 => (if T != 0) b = -aT/2
y(t) = at(t - T)/2
```

Now, to find *a*, we need to add another boundary condition that encodes our request that the jump height is *H*:

```
y(T/2) = H     // (3)
```

We know that *T/2* is the time where the jump is at its apex because y(t) is a parabula, so we impose that that point is at y = H. This gives us:

```
H = aT/2 (-T/2)/2 => a = -8H/T^2
```

Since *a* represents our gravity, let's rename it *g*. We can now derive the starting jump speed *v0* by using the primitive of our initial differential equation: 

```
y'(t) = at + b

// Recall that b = -aT/2 = -gT/2
v0 = y'(0) = -gT/2
```

So, to recap: given a parabolic jump with given duration T and height H, we can derive the required inputs for the equation of motion (i.e. gravity and initial velocity) like this: 

```
g = -8H/T^2
v0 = -gT/2
```

### Godot example

In my friend's case, she was implementing her kinematic character using the [Godot Engine](https://godotengine.org/). We can translate the theory above in GDscript form like this:

```
class_name MyCharacter
extends KinematicBody2D

export var jump_duration: float  # T
export var jump_height: float    # H

var velocity: Vector2
var gravity: float

func _ready():
    # Compute the gravity (g) once here
    gravity = 8 * (jump_height / pow(jump_duration, 2))


func _physics_process(delta: float):
    # Nothing interesting here, just update the velocity and move the character
    velocity.y += gravity * delta
    velocity = move_and_slide(velocity, Vector2(0, 1))


func _input(event: InputEvent):
    if event.is_action_pressed("jump"):
        # Set the initial jump velocity (v0) here
        velocity.y -= gravity * 0.5 * jump_duration
```

This will work as expected as long as the duration and height parameters are within "safe" ranges. If the product `T * H` gets too high, *v0* may become too big for the physics simulation to properly handle. If you try and use this technique in your game, test it with different values and find how far can you take it before relying too heavily on it.
