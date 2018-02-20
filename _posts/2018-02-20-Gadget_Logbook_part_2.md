---
title: Gadget Logbook part 2
author: silverweed
layout: single
tags:
- graphic programming  
- opengl  
- d  
- gadget  
---

[Part 1](/Gadget_Logbook_part_1/) covered library bindings, basic drawing, lighting and 
instanced drawing. Let's continue from there.

### Step 4: Multiple light casters
Light casters are scene elements that produce a light of some kind. The most common ones are
*directional lights*, *point lights* and *spot lights*. 

At this point, Gadget only supported a single point light, which is not very interesting.
So the next step I took was to remove this limitation by supporting multiple point lights and a 
directional light. I didn't bother to add multiple directional lights yet, because it's quite rare
to have more than one at a time (it's usually used as the sunlight, and there's usually a single sun
in the sky at any given moment).

Among other things, adding more lights involves changing the shaders to pass more than one light at
a time. To keep it simple, I initially chose an arbitrary maximum number of lights and passed them
via an uniform array:

```
// Before:
// uniform PointLight pointLight;

// After:
uniform PointLight pointLight[MAX_POINT_LIGHTS];
uniform DirLight dirLight;
```

The fragment shader simply sums the results of all the single light calculations.

Adding 10 point lights and a greenish directional light (and darkening the sky to better appreciate them)
yields a reasonably nice result:

<figure>
  <a href='/assets/video/gadget/multiplelights.webm'>
    <video style='width: 100%' src='/assets/video/gadget/multiplelights.webm' alt='Multiple lights' loop muted preload autoplay>
      Your browser does not support HTML5.
    </video>
  </a>
</figure>

### Leveraging D features
At this point, I'd like to make a brief digression.
D allows for several interesting "tricks" that can make development easier.

First "trick": I'm currently defining the shaders in the D source itself, rather than as separate files.
This allows me to share the user-defined data structures between the D and GLSL code. 

It works like this:

first, in D, I define a "data structure generator" as a compile-time constant string:

```
enum GenPointLight = q{
	struct Material {
		vec3 diffuse;
		vec3 specular;
		float shininess;
	};
};
```

The `q{}` syntax defines a "token string", which is a multiline string that is required to only contain 
valid D code. The `enum` keyword in D is more general than in most programming languages, as it defines
an arbitrary compile time constant, not only an enumeration of values (kinda like `constexpr` in C++).

Then, I use a [mixin](https://dlang.org/articles/mixin.html) to embed the string I just defined into
the program:

```
mixin(GenMaterial);
```

This is exactly as if I had manually written the token string contained in `q{}` in the source code.
Kinda like a macro substitution in C, but semantically parsed by the D compiler.

Finally, I *prepend* the string `GenPointLight` to every shader body, so they contain the exact same
definition of `Material` that's known to the D code. This works because the D syntax and the GLSL
syntax to declare a user-defined type are (almost) the same, so both languages are happy with the same
string.

```
enum fs_blinnPhong = GenPointLight ~ q{
	...
};
```

Naturally, types like `vec3` or `sampler2D` which are primitive in GLSL must be defined in
some way in D, but luckily the Gl3n library does indeed define most of them, and we can get away with 
types like `sampler2D` by typedef'ing them to `uint`.

With this trick, we can group all user types definitions in a common "shader header" string to embed
in all shader definitions, with the convenience that every time we change those types' definitions
the change is automatically reflected in all of them. The same goes for `#define`d constants.

```
enum SHADER_HEADER = `
#version 330 core

#define MAX_POINT_LIGHTS ` ~to!string(MAX_POINT_LIGHTS) ~ `

` ~ GenMaterial ~ `
` ~ GenPointLight ~ `
` ~ GenDirLight ~ `
` ~ GenAmbientLight;
```

### Step 5: Shadow mapping
Once you have light, you want shadows. Well, this may not be an universal law, but I definitely wanted them.

Adding shadows to a scene is a non-trivial operation. It involves rendering the scene multiple times,
getting intermediate results and put them together at the end.

Since I knew the time was coming for refactoring, I started by making all the data structures
"less object oriented", mainly by removing most of their methods and converting them to independent functions.
Luckily, D has [UFCS](https://en.wikipedia.org/wiki/Uniform_Function_Call_Syntax) which made this transition
painless.

I did this because I wanted to have a clear separation between the *data* I'm handling and their *transformations*,
which proves very useful on the long run, especially when you're not sure where you're gonna go with your code.

The next step was implementing rendering to texture. Basically, instead of drawing the scene directly to the
framebuffer, you paint it on a texture which then you draw on a quad covering the screen.
This intermediate step is required both by shadow mapping and by postprocessing.

Once this was set up, adding shadow mapping was pretty straightforward. I only implemented directional shadows,
as it's the easiest type of shadow mapping you can think of. It goes vaguely like this:  

- draw the scene on a render texture (the "shadow map") as seen from the point of view of the directional light
  (using an orthographic projection); instead of painting colors on the texture, just save the distance of 
  every pixel from the light itself (or rather, from a point along the light direction, as technically the
  directional light has no position)
- draw the scene again, this time from the camera's point of view. For each pixel, compare its distance
  from the light with the value sampled from the shadow map. It the latter is smaller than the first, then
  the pixel is in shadow, as some other piece of geometry is between it and the light.

We can now enjoy those beautiful shadows!

<figure>
  <a href='/assets/video/gadget/shadows.webm'>
    <video style='width: 100%' src='/assets/video/gadget/shadows.webm' alt='Directional shadows' loop muted preload autoplay>
      Your browser does not support HTML5.
    </video>
  </a>
</figure>


### Up next

Next improvements include textures, skyboxes and making stuff move on the screen. I'm not sure when I'll
come up with the follow-up, but stay tuned for updates if you're interested.
As always, thanks for reading this far :-)
