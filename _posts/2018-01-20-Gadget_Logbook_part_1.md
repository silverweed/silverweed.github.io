---
title: Gadget Logbook part 1
author: silverweed
layout: single
tags:  
- graphic programming  
- opengl  
- d  
- gadget  
---

## The Gadget project
I've been working on a project named Gadget (as in [Gadget Hackwrench](http://disney.wikia.com/wiki/Gadget_Hackwrench))
for about 3 months now, and I've just decided I'll keep a sort of logbook on this blog ("blogbook"?)
to keep myself motivated and share the progress on it.

The original idea was to write a toy physics engine from scratch, but then I realized I needed some sort
of visual representation of what was going to happen, so I started coding a rendering engine instead.
After all, it's a great opportunity to learn some graphics programming and more specifically, OpenGL.

If you're interested, you can find its source code [here](https://github.com/silverweed/gadget).

## Tools of the trade

### D
As this project is for fun, I definitely didn't want C++. But at the same time I wanted to be able to use the OpenGL
API as faithfully as possible, so I chose D. It's a great programming language, it makes programming fun and productive
and its OpenGL bindings are so thin that you could literally copy-paste the API calls in a C program and they would
work (most of the time at least. There are a couple of differences mainly due to how C and D treat arrays differently).

### OpenGL
I use a library called [DerelictGL3](https://github.com/DerelictOrg/DerelictGL3) and OpenGL version 3.3 core.
This choice is due to the fact I'm still learning OpenGL, so I'm doing heavy use of the [Learn OpenGL tutorial](https://learnopengl.com/)
and it happens to use that version. Also, mobile compatibility isn't an issue, so for now I'm not bothering with
GLES (but I believe it would be quite similar to 3.3 core).

### SFML
I'm using SFML as the windowing library (as opposed to the more commonly used GLEW) because I'm already very familiar
with it, as it's the main library I use in [Lifish](/lifish). The D bindings are again provided by [DerelictSFML](http://derelictorg.github.io/packages/sfml2/).
Unfortunately, they are actually bindings to the CSFML API, so they're totally C-style and non-object oriented 
(so you write `auto t = sfClock_getElapsedTime(clock);` instead of `auto t = clock.getElapsedTime();`), but
that's not necessarily a bad thing. It keeps things simple and doesn't add uncalled-for abstractions I don't need.
Moreover, SFML is used quite little in Gadget, so the resulting C++-bound-to-C-looking code does not bloat the codebase
excessively.

### Linear algebra
The last ingredient is a helper library for linear algebra. [Gl3n](https://github.com/Dav1dde/gl3n) is more or less
the equivalent of Glm for D, and it does a great job with vectors, matrices, transformations and so on.
There are a couple of issues I don't quite appreciate of it, like the lack of operator overloading for vectors and
the reverse row ordering of matrices compared to OpenGL, but they're definitely not problematic.

## Ready, set, go!

### Step 1: draw anything
With the dependencies set up, my first goal was to get anything on screen. This step is tougher than you may expect in
OpenGL 3, as you need to perform at least the following steps:

0. Load all the needed Derelict libraries (since they're *dynamic binding* libraries).  
1. Set up the windowing system and tell it which version of OpenGL to use.  
2. Set up the GL viewport.  
3. Define some vertices to draw and store them in a buffer.  
4. Write a vertex and a fragment shader that transform the defined vertices into rendered pixels.  
5. Draw the viewport.

It is scientifically proven that 99% of the first OpenGL programs anyone writes will attempt to draw a triangle.
For some reason, I drew a rectangle instead. It's a very fulfilling moment when you actually get one to display.

![Pink rectangle](/assets/img/gadget/rectangle.png)

### Step 2: let's get 3D
Naturally, once you get it this far, only the sky's the limit. The next step I took was to draw a slightly more
interesting shape: a cube.
Also, to properly appreciate the fact that a cube has 3 dimensions, I added a FPS-like camera to be able to move
around in the world. That's cool, right? Once you have a camera (and the proper shaders), you're suddenly no longer limited
to a boring fixed 2D screen, but you get an entire *infinite 3D world* instead!

Building a first person camera is not hard, you just have to apply some extra mathematical transformation to the vertices
and bind their parameters to the mouse and keyboard events.

Together with the camera, I replaced the "hello world" shaders with something a bit more evolved which could apply
actual *lighting* to the shapes drawn on screen. The vertex shader now makes the vertices look like in 3D, while the
fragment shader fakes a point light rotating around the shapes. I used the Blinn-Phong shading model.

<figure>
  <a href='/assets/video/gadget/cube.webm'>
    <video style='width: 100%' src='/assets/video/gadget/cube.webm' alt='Cube' loop muted preload autoplay>
      Your browser does not support HTML5.
    </video>
  </a>
</figure>

It already feels like a "world" we can move into! Changing the background color also helps making it feel like a "sky".

I also wanted to visualize the light's position, so I added a separate shader that drew a billboarded quad there.
This shader was the first to use a *geometry shader* to create vertices on-the-fly around the light's position to
draw a quad out of a single point.

<figure>
  <a href='/assets/video/gadget/lightgizmo.webm'>
    <video style='width: 100%' src='/assets/video/gadget/lightgizmo.webm' alt='Light gizmo' loop muted preload autoplay>
      Your browser does not support HTML5.
    </video>
  </a>
</figure>

This addition makes life easier when debugging light-related stuff, so I thought it was best to have early on.

### Step 3: draw LOTS of cubes!
Keeping in mind that my final goal is to use this "rendering engine" to visualize the result of the forthcoming physics
engine, one of Gadget's basic requirements is to be able to render a very high number of objects at the same time.

For this reason, I decided to implement instanced rendering right away. Instancing is, more or less,
the process of drawing multiple versions of the same object "at once", without explicitly storing a separate
vertex buffer for each. It complicates things a bit, as all shaders that work in an instanced fashion need to be rewritten
(e.g. to pass the model matrix as a vertex attribute rather than an uniform), but once you set up the machinery, it
gets pretty simple to build upon it.

To make sure that instancing actually helps, I drew THOUSANDS of cubes at once, all differing but by their world 
transform and their color. Turns out instancing actually worked and FPS never dropped below 60.

<figure>
  <a href='/assets/video/gadget/instancedcubes.webm'>
    <video style='width: 100%' src='/assets/video/gadget/instancedcubes.webm' alt='Instanced cubes' loop muted preload autoplay>
      Your browser does not support HTML5.
    </video>
  </a>
</figure>

To make the world a little more "concrete" I'm now drawing a huge quad to serve as a "ground". Notice that all cubes,
as well as the ground, have their own correct Blinn-Phong shading and are stretched and rotated in different ways
despite sharing a single vertex buffer for their basic geometry. Instancing rocks!

## Up next
For now I'm wrapping this post up, lest it gets too long. Part 2 will deal with multiple light casters, shadow mapping
and other neat stuff. A lot of code changes from now on are actually invisible, as they deal with the internal
architecture of the code, but I think I'll cover at least some of them anyway.

In part 3 I will probably reach the lastest progress I've done so far, so updates will slow down as I first have to
develop things before I write about them :-)

See you next time.
