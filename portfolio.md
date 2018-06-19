---
layout: default 
title: silverweed's portfolio
permalink: /portfolio/
---

<link href="https://fonts.googleapis.com/css?family=Josefin+Sans" rel="stylesheet"> 
<style>
li {
	margin-bottom: 0px !important;
}
div.game {
	display: flex;
  flex-direction: column;
	max-width: 1280px;
	margin-left: auto;
	margin-right: auto;
}
div.gamedesc {
	padding: 10px;
  flex-grow: 1;
}
.gamelist {
	list-style-type: none;
	padding: 0;
}
.game-imgs {
  display: flex;
  flex-wrap: wrap;
}
.game-imgs a {
  position: relative;
  max-width: 45%;
  max-width: 400px;
}
.game-imgs img, video {
  height: auto;
  width: 100%;
  display: block;
}
.game-imgs img.play {
  width: 50%;
  position: absolute;
  opacity: 0.8;
  left: 30%;
  top: 16%;
}
.gamedesc p {
  margin: 0.1em !important;
}
.gamedesc h1 {
  margin-top: 1em;
  font-family: 'Josefin Sans', sans-serif;
}
.gamedesc h2, h3, h4, h5, h6 {
  margin-top: 0.1em;
  margin-bottom: 0.1em;
  font-family: 'Josefin Sans', sans-serif;
}
.game-imgs video {
	display: none;
}
</style>

<ul class='gamelist'>
  <li style='background: rgba(210, 210, 210, 1.0)'>
    <div class='game'>
      <div class='gamedesc'>
        <h1>Lifish</h1>
        <h3>Roles: programmer, designer</h3>
        <p>Lifish was born in 2015 as an open source clone of an old Mac game called <em>BOOM</em>, 
        a "Bomberman meets Doom" arcade game. The source code is available
        <a href="https://github.com/silverweed/lifish">on Github</a>.</p>
        <p>The project later evolved into an original game, preserving most original BOOM mechanics 
        while adding on bosses, enemies and powerups.</p>
        <p>As a <strong>programmer</strong>, I basically wrote the entire thing. Lifish uses a custom C++
        engine leveraging the <a href="https://www.sfml-dev.org/">SFML</a> multimedia library for
        multi-platform deployment (the game runs on Linux, Mac, Windows and FreeBSD).</p>
        <p>As a <strong>designer</strong>, I'm creating the new levels, bosses, enemies, attacks and
        powerups that make Lifish more than just a clone of the original game.</p>
        <p>Lifish is still under development, mainly on the graphical side, as the current "programmer art"
        is going to be replaced by the final version (which is being made by another person).</p>
      </div>
      <div class='game-imgs'>
        <a href='/assets/img/lifish_screen1.png'><img src="/assets/img/lifish_screen1.png" alt="Lifish"/></a>
        <a href='/assets/video/rex_atk.webm'>
          <img class="thumb" src="/assets/video/rex_atk_thumb.png" alt="Lifish"/>
          <video src="/assets/video/rex_atk.webm" alt="Lifish"></video>
        </a>
        <a href='/assets/img/lifish_lv11.png'><img src="/assets/img/lifish_lv11.png" alt="Lifish"/></a>
        <a href='/assets/img/lifish_lv30.png'><img src="/assets/img/lifish_lv30.png" alt="Lifish"/></a>
      </div>
    </div>
  </li>
  <li style='background: rgba(220, 220, 220, 1.0)'>
    <div class='game'>
      <div class='gamedesc' style='align-self: flex-start'>
        <h1>Gadget</h1>
        <h3>Roles: programmer</h3>
        <p>An ongoing "toy" rendering engine I'm doing in my free time as a way to get a solid grasp on OpenGL and graphics
        programming. My plan is to also integrate it with a physics engine in the future.</p>
        <p>Gadget is written in D and uses OpenGL + SFML for windowing. It's currently only being tested on Linux.</p>
        <p>Its source code is available <a href="https://github.com/silverweed/gadget">on Github</a>.</p>
        <p>Currently, after a couple of months of work, Gadget features: basic primitive drawing, instanced drawing,
        texturing, diffuse/specular/normal maps, ambient/directional/point lights, Blinn-Phong shading, shadow mapping and skybox drawing.</p>
        <p>Work on Gadget is currently on hiatus due to me working on a similar project for my Master thesis, 
        but you can read a couple of articles about it <a href="http://localhost:4000/tags/#gadget">on my blog</a>.</p>
      </div>
      <div class='game-imgs'>
        <a href='/assets/img/gadget/cubes.png'>
          <img src="/assets/img/gadget/cubes.png" alt="Gadget"/>
        </a>
        <a href='/assets/video/gadget/multiplelights.webm'>
          <img class="thumb" src="/assets/video/gadget/multiplelights_thumb.png" alt="Gadget"/>
          <video src="/assets/video/gadget/multiplelights_small.webm" alt="Gadget"></video>
        </a>
        <a href='/assets/video/gadget/shadows.webm'>
          <img class="thumb" src="/assets/video/gadget/shadows_thumb.png" alt="Gadget"/>
          <video src="/assets/video/gadget/shadows_small.webm" alt="Gadget"></video>
        </a>
        <a href='/assets/img/gadget/gadget_screen1.png'>
          <img src="/assets/img/gadget/gadget_screen1.png" alt="Gadget"/>
        </a>
      </div>
    </div>
  </li>
  <li style='background: rgba(210, 210, 210, 1.0)'>
    <div class='game'>
      <div class='gamedesc' style='align-self: flex-start'>
        <h1>GIVE - I Guardiani Del Corpo</h1>
        <h3>Roles: programming, materials, levels, some 3D models and animations</h3>
        <p>GIVE was my first commissioned game and also my first one made with Unreal Engine.</p>
        <p>The final product is the result of one year of work from a team of 2 people. My main role
        in the team was gameplay programming, but I also contributed some 3D models, animations
        and most materials.</p>
        <p>GIVE is a sidescrolling shoot-em-up where you control white blood cells with the
        goal to safely escort the erythrocytes inside a blood vessel, defending them from bacteria.
        The game uses most of the classic mechanics of the genre, plus some extra elements such as "blood transfusion".</p>
        <p>The game features local multiplayer up to 4 people, allowing joining in mid-game in a perfect
        arcade fashion. There are 4 playable characters, each with its own basic attack and "bomb",
        3 levels, each with its unique boss, and a bunch of enemies with different patterns.</p>
      </div>
      <div class='game-imgs'>
        <a href='/assets/img/give/give_gameplay1.png'>
          <img src="/assets/img/give/give_gameplay1.png" alt="GIVE"/>
        </a>
        <a href='/assets/video/gives/buddy_boss_lv1.mp4'>
          <img class="thumb" src="/assets/video/give/buddy_boss_lv1_thumb.png" alt="GIVE"/>
          <video src="/assets/video/give/buddy_boss_small.webm" alt="GIVE"></video>
        </a>
        <a href='/assets/img/give/boss_lv3.png'>
          <img src="/assets/img/give/boss_lv3.png" alt="GIVE"/>
        </a>
        <a href='/assets/img/give/nuke_explosion.png'>
          <img src="/assets/img/give/nuke_explosion.png" alt="GIVE"/>
        </a>
        <a href='/assets/img/give/give_selection.png'>
          <img src="/assets/img/give/give_selection.png" alt="GIVE"/>
        </a>
        <a href='/assets/video/give/tiny.mp4'>
          <img class="thumb" src="/assets/video/give/tiny_thumb.png" alt="GIVE"/>
          <video src="/assets/video/give/tiny_small.webm" alt="GIVE"></video>
        </a>
      </div>
    </div>
  </li>
  <li style='background: rgba(220, 220, 220, 1.0)'>
    <div class='game'>
      <div class='gamedesc' style='align-self: flex-start'>
        <h1>Hacknid</h1>
        <h3>Roles: gameplay, shader and tool programmer</h3>
        <p>Hacknid is a game made in 48 hours for Global Game Jam 2018 by a team of 4 people, available for
        download <a href="https://globalgamejam.org/2018/games/hacknid">here</a>.</p>
        <p>It's a 2D puzzle/stealth game where you must get to the end of the level by controlling not only
        your character, but enemies as well.</p>
        <p>As the game received positive feedback, we kept on developing Hacknid to expand it into a full
        game. Like during the jam, I'm the main programmer both for gameplay and shading.</p>
        <p>We're using GameMaker Studio, but as our game needs lots of levels we developed our own external
        level editor in C# / WPF to ease the work of designers.</p> 
      </div>
      <div class='game-imgs'>
        <a href='/assets/img/hacknid/hacknid_gameplay1.png'>
          <img src="/assets/img/hacknid/hacknid_gameplay1.png" alt="Hacknid"/>
        </a>
        <a href='/assets/video/hacknid/hacknid_gameplay.webm'>
          <img class='thumb' src="/assets/video/hacknid/hacknid_gameplay.png" alt="Hacknid"/>
          <video src="/assets/video/hacknid/hacknid_gameplay_small.webm" alt="Hacknid"/>
        </a>
        <a href='/assets/img/hacknid/hacknid_menu.png'>
          <img src="/assets/img/hacknid/hacknid_menu.png" alt="Hacknid"/>
        </a>
        <a href='/assets/img/hacknid/hacknid_gameplay2.png'>
          <img src="/assets/img/hacknid/hacknid_gameplay2.png" alt="Hacknid"/>
        </a>
        <a href='/assets/img/hacknid/hacknid_gameplay3.png'>
          <img src="/assets/img/hacknid/hacknid_gameplay3.png" alt="Hacknid"/>
        </a>
        <a href='/assets/video/hacknid/hacknid_gameplay2.webm'>
          <img class='thumb' src="/assets/video/hacknid/hacknid_gameplay2.png" alt="Hacknid"/>
          <video src="/assets/video/hacknid/hacknid_gameplay2_small.webm" alt="Hacknid"/>
        </a>
      </div>
    </div>
  </li>
</ul>

<script>
var isMobile = /(Android|webOS|iPhone|iPad|iPod|BlackBerry|Windows Phone)/i.test(navigator.userAgent);

function addPlaySymbol(elem) {
	  var play = document.createElement('img');
	  play.src='/assets/img/play.svg';
	  play.className = 'play';
	  var bound = elem.getBoundingClientRect();
	  elem.parentNode.appendChild(play);
	  return play;
}

if (!isMobile) {
	document.querySelectorAll('video').forEach(video => {

	  var thumb = video.parentNode.querySelector('img.thumb');
	  thumb.style.display = 'none';
	  video.style.display = "block";

	  video.muted = true;
	  video.loop = true;

	  // Add play symbol
	  var play = addPlaySymbol(video);

	  // Hover play/pause
	  play.addEventListener('mouseenter', ((video, play) => {
	    return () => {
	      video.play();
	      play.style.visibility = 'hidden';
	    };
	  })(video, play));
	  video.addEventListener('mouseleave', ((video, play) => {
	    return () => {
	      video.pause();
	      play.style.visibility = 'visible';
	    };
	  })(video, play));
	});
} else {
	// is mobile
	document.querySelectorAll('.thumb').forEach(img => {
		addPlaySymbol(img);
	});
}
</script>
