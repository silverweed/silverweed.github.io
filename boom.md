---
layout: single
title: BOOM (remake) 
permalink: /boom/
---
<style>
img.preview {
	height: 250px;
}
p.discl {
	background-color: #ff7f7f;
	color: #910000;
	padding: 4px;
}
.changelog ul {
	line-height: 20px;
	margin-top: 10px;
}
</style>

<a href='#downloads'>Jump to downloads</a>

BOOM was a [shareware game for MacOS](https://www.macintoshrepository.org/3582-boom) created by Federico Filipponi (FactorSoftware). The game's slogan was "Bomberman meets DOOM": you could play solo or in local coop throughout 80 levels, facing a plethora of different enemies, intermediate bosses and a final Big Alien Boss.

<a href='/assets/img/boom/boom_screen1.png'>
  <img class='preview' src="/assets/img/boom/boom_screen1.png"/>
</a>
<a href='/assets/img/boom/boom_screen2.png'>
  <img class='preview' src="/assets/img/boom/boom_screen2.png"/>
</a>

Unfortunately, the game's original site is not accessible anymore, so BOOM can only be downloaded from archives found on the Internet.

I played BOOM a lot, since when I was a kid, and it is the game that made me venture on the game developing path. Maybe, if it weren't for that game, I wouldn't be developing games at all nowadays. 

For this reason, in 2015 I decided to start working on a complete remake for the game. That project would eventually become [Lifish](/lifish/). But alas, making a game is hard and takes a lot of time, so Lifish still isn't complete yet. 

However, as most of the code is there, I figured in the meantime I could work on a mod that, changing a bit of gameplay logic and borrowing assets from the original game, could effectively become a faithful remake of BOOM! So there it is, a game as close to the original Factor Software's BOOM, playable on Windows, Mac and Linux completely for free!

<b>Note:</b> <em>BOOM: Remake</em> shares most of its codebase with Lifish and, like it, it is free software. The source code is available [here](https://github.com/silverweed/lifish) under the branch <code>boom</code>.

<p class='discl'><b>DISCLAIMER</b>: all graphics and audio assets in the game belong to Factor Software. This game is a remake distributed free of charge with the aim to preserve the original game from obsolescence. If you are the owner of BOOM assets and want this game to be taken down, contact me at silverweed1991@gmail.com</p>

<hr>

<h3 id='known_issues'>KNOWN ISSUES</h3>
<ul>
  <li>Input does not work on OSX Catalina <a href="https://github.com/silverweed/lifish/issues/6#issuecomment-585331958">unless global event capture is allowed</a>. This is due to Apple's new security policy and <strong>will not be fixed for the time being</strong>.</li>
  <li>The app is unsigned, so a warning may be displayed when starting it. This will <strong>not</strong> be fixed either.</li>
</ul>

<h3 id='utils'>UTILITIES</h3>
<h4 id='editor'>Level Editor</h4>
<p>An experimental level editor <a href="https://github.com/silverweed/lifish-edit/releases">is available</a>, currently in packaged version for Mac only. It can be compiled for Linux as well, but unfortunately there is no Windows support, due to the Crystal programming language not supporting it.</p>

<h4 id='levelgen'>Random Level Generator</h4>
<p>There is also a <a href="https://github.com/silverweed/boomlevelgen">random level generator</a> available, working for both the original BOOM and BOOM Remake. It requires Python 3 to run.</p>

<h3 id='downloads'>DOWNLOADS</h3>

<ul>
  <li><a href='/assets/games/lifish/lifish_BOOM_1.5.2_linux_x64.tar.xz'>BOOM Remake (Linux 64 bit)</a></li>
  <li><a href='/assets/games/lifish/lifish_BOOM_1.5.2_windows_x64.zip'>BOOM Remake (Windows 64 bit)</a></li>
  <li><a href='/assets/games/lifish/lifish_BOOM_1.5.2_osx.zip'>BOOM Remake (OSX)</a></li>
</ul>

<h3 id='changelog'>CHANGELOG</h3>

<dl class='changelog'>
  <dt><strong>1.5.2 (current)</strong></dt>
  <dd>
    <ul>
      <li>Added in-game timer overlay to preferences (mainly for speedrun purposes)</li>
      <li>Added Italian version</li>
    </ul>
  </dd>
  <dt>1.5.1</dt>
  <dd>
    <ul>
      <li>Fixed the game failing to save if the saves directory is missing</li>
      <li>The game is now built with MSVC, rather than MinGW, on Windows</li>
    </ul>
  </dd>
  <dt>1.5.0</dt>
  <dd>
    <ul>
      <li>Bumped SFML version to 2.5</li>
      <li>Error screen now brings back to home instead of exiting the game</li>
      <li>Pressing Esc during the game now brings up the Pause menu instead of killing the players</li>
    </ul>
  </dd>
  <dt>1.4.0</dt>
  <dd>
    <ul>
      <li>Fixed teleporters warping a player standing still</li>
      <li>Fixed the player continuing to move after warping in a teleporter</li>
      <li>Fixed the player being teleported upon hit while standing on a teleporter</li>
      <li>Fixed a bug where the player could be hit by an enemy from behind a wall diagonally</li>
      <li>Added 'Show FPS' and 'Vsync' options to Preferences</li>
    </ul>
  </dd>
  <dt>1.3.1</dt>
  <dd>
    <ul>
      <li>Fixed enemies sometimes dealing damage to a player behind a teleporter</li>
      <li>Fixed bombs' damage to bosses: now bombs deal exactly 5 damage when place underneath a boss tile like in the original game</li>
      <li>Fixed bosses' fire rate not doubling during Hurry Up</li>
      <li>Added fullscreen mode in the Preferences menu</li>
      <li>Fixed the player playng the hurt animation when contacting dead enemies</li>
      <li>Fixed Mean-O-Taurs and Ghosts attacking during Extra Game</li>
    </ul>
  </dd>
  <dt>1.3.0</dt>
  <dd>
    <ul>
      <li>Fixed save/load</li>
      <li>Fixed several teleporter behaviours to make them more similar to the original game</li>
      <li>Fixed a bug that made the game crash when a player was hit by a Big Alien Boss Egg</li>
      <li>Fixed a softlock that sometimes happened when distributing points on end level</li>
      <li>The 'Get Ready!' screen can now be skipped by pressing the Bomb or the LMB button</li>
    </ul>
  </dd>
  <dt>1.2.3</dt>
  <dd>
    <ul>
      <li>Preferences are now preserved when exiting and re-running the game</li>
      <li>Passing an invalid levelset via the command line will now show a visual error rather than panicking</li>
    </ul>
  </dd>
  <dt>1.2.2</dt>
  <dd>
    <ul>
      <li>Tweaked several parameters to make the game more close to the original BOOM</li>
      <li>Fixed enemies not properly colliding with players when players are moving</li>
      <li>Fixed bosses not being in sync when shooting</li>
      <li>Fixed time bonus giving more points than intended</li>
      <li>Fixed an issue with Ghosts animation</li>
    </ul>
  </dd>
  <dt>1.2.1</dt>
  <dd>
    <ul>
      <li>Added single-player mode</li>
    </ul>
  </dd>
  <dt>1.2</dt>
  <dd>
    <ul>
      <li>First release</li>
    </ul>
  </dd>
</dl>
