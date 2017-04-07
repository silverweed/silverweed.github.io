---
title: vim, g++ and the joy of creation (part 2)
author: silverweed
layout: single
tags:
  - programming
  - random
---

[Part 1 is here](/vim,_g++_and_the_joy_of_creation/).

My first text editor was [Gedit](https://wiki.gnome.org/Apps/Gedit), a very simple and intuitive
editor with your classical keybindings like Ctrl+C, Ctrl+V and Ctrl+Z. At that time, my favourite
feature was probably syntax highlighting. I'd never had it before, after all, and it made the
source code so *colorful*!

In case you couldn't tell by my editor choice, my programming adventure started alongside
my experience with Linux (at the time, Fedora was installed on my university's lab's machines).
Today, I still always program under Linux whenever I can: I'm just too comfortable with it to ever change.

### Enter Vim ###
Then, one day, I tried Vim. I owe it, along with many other stuff, to a good friend of mine who was,
like me and probably even more so, an enthusiastic explorer of our newfound world of programming.
We had both heard of Vim from another student during a Computer Science lesson and he just went and
said "Let's try this 'super cool editor'!".

He was probably ironic, as in the beginning we were mostly
laughing at the ridiculously unnecessarily complex command shortcuts and the way you wrote and saved.
What kind of a**hole would type `i` just to ask permission to start writing and an impossible-to-remember
sequence like `<Esc>:x` to freaking save?

Yet, for the taste of challenge, we didn't give up. I still used Gedit when I had to have something coded
"quick", but in my spare time still had fun with Vim. One of the moments I cherish most of the learning
process is when a friend of ours unveiled the secred of "how to insert a new character at the beginning
of several lines". While it may not look like a task you'd do frequently, it turned out amazingly
useful, so much that I actually got to remember the sequence of commands to do it.

Things turned out to have MUCH more sense when I actually understood why things were like that.

So, without even noticing, we both became a lot more productive with Vim than with Gedit, and today
I wouldn't give up my Vim bindings for anything.

### Why I don't like IDEs all that much ###
This is probably related to my personal experience, but in the end I kinda dislike IDEs.
I'm speaking of the all-in-one, feature-complete apps which are not only a text editor, but also
a compiler, a static analyzer, a debugger, an emulator, etc.

Firstly because I like my text editor to have a zero-seconds start-up time, but this is admittedly
a poor argument. Then, I like to have
my favourite text editor always available on virtually any computer other than mine (on every Linux
distribution Vim is either already there or at a few megs of download away). Then again, I like
being able to SSH into a remote machine and fire my text editor without the need for X forwarding or
remote desktop. Moreover, I like having the shell just a Ctrl-Z away from me.

Last but not least, I believe in the Unix philosophy of having many small programs doing only one thing
-- but doing it *well* -- rather than a single factotum program. Especially if that program is several
GBs and I'm stuck with a 5Mbps ADSL.

This is not a hermit's philosophy. I don't renounce to the convenience of having semantic autocompletion,
debugging, static analysis, etc.
I just have a plugin for autocompletion, use `gdb` for debugging, `clang` or something like
[Coverity](https://scan.coverity.com/) for static analysis and so on.

It's really a philosophy of
"Keep It Simple, Stupid". When you have many different pieces that do their job and you decide you
don't like one of them, it's easy to replace it.

But what's more worth about the whole idea is that you *get to know* -- and possibly understand -- what's
happening under the hood. Since you're the one responsible for putting the pieces of your working
environment together, you *have* to understand to some extent how do they work. When more things are
involved, more things are likely to break, that's true. But when they do, you get to learn something
new. More burden, more occasions. More pain, more gain.

That's why I'll always prefer a long and painfully-written `g++` command line to the convenience of
pushing a "Compile" button.


---
Sorry for the lack of pictures, but the topics discussed didn't really call for any. I'll try to be more
picture-y in the next post!

Thanks for reading, until next time ;-)
