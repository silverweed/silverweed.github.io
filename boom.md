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
}
.changelog ul {
	line-height: 15px;
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

<p class='discl'><b>DISCLAIMER</b>: all graphics and audio assets in the game belong to Factor Software. This game is a remake distributed free of charge with the aim to preserve the original game from obsolescence. If you are the owner of BOOM assets and want this game to be taken down, contact me at silverweed1991@gmail.com</p>

<hr>

<h3 id='downloads'>DOWNLOADS</h3>

<ul>
  <li><a href='/assets/games/lifish/lifish_BOOM_1.3.0_linux_x64.tar.xz'>BOOM Remake (Linux 64 bit)</a></li>
  <li><a href='/assets/games/lifish/lifish_BOOM_1.3.0_windows_x64.zip'>BOOM Remake (Windows 64 bit)</a></li>
  <li><a href='/assets/games/lifish/lifish_BOOM_1.3.0_osx.zip'>BOOM Remake (OSX)</a></li>
</ul>

<h3 id='changelog'>CHANGELOG</h3>

<dl class='changelog'>
  <dt><strong>1.3.0 (current)</strong></dt>
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
