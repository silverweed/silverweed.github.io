---
title: BOOM Remake now available as Linux AppImage
author: silverweed
layout: single
tags:
  - boom  
  - videogame  
  - lifish  
---
A new version of *BOOM: Remake* is out: 1.8.0! This new version brings two main changes:

### Linux release is now an AppImage ###
Good news for all Linux players: *BOOM: Remake* will now get a proper Linux release as an [AppImage](https://appimage.org/), rather than the mostly-broken manually-packaged version that was distributed up until now.
The AppImage should be able to run on almost all Linux distributions with little to no effort. You can read more about it on the website linked above, but in a nutshell, you just `chmod +x` the file and run it.
As an extra bonus, a version for aarch64 is now also available, in addition to x86\_64. You can find both in the [downloads page](https://silverweed.github.io/boom#downloads).

Huge thanks to [@orazioedoardo](https://github.com/orazioedoardo) for making this happen: he literally did all the work for it!

### Save data location change on Linux ###
Starting with this release, the Linux version of the game will use different locations for the following files:

- **Levels Files**: will move from the game's root folder to `assets/`;  
- **Save Files and High Scores**: will move from `saves/` to `XDG_DATA_HOME/lifish`, falling back to `~/.local/share/lifish`;  
- **Preferences File**: will move from the game's root folder to `XDG_CONFIG_HOME/lifish`, falling back to `~/.config/lifish`.

Keep this in mind if you wanna use your previous saves, levels or preferences after upgrading the game's version!

As always, happy bombing!
