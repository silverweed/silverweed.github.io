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
.gamedesc.right {
  justify-content: flex-end;
}
</style>

<ul class='gamelist'>
  <li style='background: rgba(250, 250, 250, 1.0)'>
    <div class="game">
      <div class="gamedesc right">
        <!-- Hi, mom! I'm a game! -->
        <h1>About me</h1>
        <p>I'm Giacomo Parolini.</p>
        <p>I like science, especially Physics.</p>
        <p>I like games, especially videogames.</p>
        <p>I like programming, especially game programming.</p>
        <p>Read more about me and what I do <a href="https://silverweed.github.io/about_this_blog_(and_its_author)">on my blog</a> if you're interested!</p>
      </div>
    </div>
  </li>
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
        <p>An ongoing "toy" rendering engine I'm doing in my free time as a way to get a solid grasp on OpenGL and graphics
        programming. My plan is to also integrate it with a physics engine in the future.</p>
        <p>Gadget is written in D and uses OpenGL + SFML for windowing. It's currently only being tested on Linux.</p>
        <p>Its source code is available <a href="https://github.com/silverweed/gadget">on Github</a>.</p>
        <p>Currently, after a couple of months of work, Gadget features: basic primitive drawing, instanced drawing,
        texturing, diffuse/specular/normal maps, ambient/directional/multiple point lights, 
	Blinn-Phong shading, shadow mapping and skybox drawing.</p>
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
        <p>GIVE is a sidescrolling shoot-em-up for PC where you control white blood cells with the
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
        <a href='/assets/video/give/buddy_boss_lv1.mp4'>
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
        <p>&nbsp;&nbsp;<i class='fa fa-fw fa-arrow-right'></i> <a href="https://www.youtube.com/watch?v=cNoHH2No_1M&index=60&list=PL4QF7lP4PZkBYflnk-bkJd_fs57Exw-YN">trailer</a></p>
        <p>Hacknid is a game made in 48 hours for Global Game Jam 2018 by a team of 4 people, available for
        download <a href="https://globalgamejam.org/2018/games/hacknid">here</a>. You can also 
        <a href="http://localhost:4000/hacknid-play/">play it in your browser</a> (you'll need mouse+keyboard or
        a joystick).</p>
        <p>It's a 2D puzzle/stealth game for PC where you must get to the end of the level by controlling not only
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
  <li style='background: rgba(210, 210, 210, 1.0)'>
    <div class='game'>
      <div class='gamedesc' style='align-self: flex-start'>
        <h1>Master Thesis [currently unnamed]</h1>
        <p>My Master Thesis project, written in C++14 using the Vulkan API. Runs on Linux and Windows.</p>
        <p>This project explores the concept of a “distributed rendering engine” for videogames with the aim to split the graphics
        pipeline between a server and a client. My goal is to create a hybrid model between  the "classic heavyweight
        client" model (where the client makes all the processing needed for rendering) and the more recent 
        "streaming" model
        (where the server does all the processing and sends the stream of rendered frames to the client).</p>
        <p>In my project, models, textures and shaders live on the server, which does most of the application-stage
        work. Then, rather than rendering models and sending frames to the client, it sends preprocessed geometry data
        to it, which in turn runs all the following pipeline stages.</p>
        <p>This project is work in progress. As such, no significant images or videos are available yet.</p>
      </div>
      <div class='game-imgs'>
        <a href='/assets/img/thesis_noimg.png'>
          <img src="/assets/img/thesis_noimg.png" alt="Thesis"/>
        </a>
      </div>
    </div>
  </li>
  <li style='background: rgba(220, 220, 220, 1.0)'>
    <div class='game'>
      <div class='gamedesc' style='align-self: flex-start'>
        <h1>qU</h1>
        <h3>Roles: programmer</h3>
        <p>A 2D puzzle game for mobile, developed in a team of 3 people as a project for the university course of Mobile Computing.
        We used the Unity game engine.</p>
        <p>The game is available on <a href="https://play.google.com/store/apps/details?id=it.unimi.qu">Play Store</a>, 
        <a href="https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1291428731&mt=8">App Store</a>
        and <a href="https://www.microsoft.com/it-it/p/qu-save-the-colors/9ndgt6pm721n">Windows Store</a>.</p>
        <p>Save as many "qU" as possible by tapping the matching color before the blades close on them.</p>
        <p>Features 10 levels and a collectible card achievement system.</p>
        <p>qU was designed as a way to collect anonymous data for an academy research 
        on color perception. Therefore, the game has a builtin data collection system which
        records the player's results and sends them to an external database.</p>
        <p>I wrote the whole data collection system, as well as a significant part of the
        gameplay code.</p>
      </div>
      <div class='game-imgs'>
        <a href='/assets/img/qU/qu_gameplay1.png'>
          <img src="/assets/img/qU/qu_gameplay1.png" alt="qU"/>
        </a>
        <a href='/assets/img/qU/qu_gameplay2.png'>
          <img src="/assets/img/qU/qu_gameplay2.png" alt="qU"/>
        </a>
        <a href='/assets/img/qU/qu_card_unlocked.png'>
          <img src="/assets/img/qU/qu_card_unlocked.png" alt="qU"/>
        </a>
        <a href='/assets/img/qU/qu_map.png'>
          <img src="/assets/img/qU/qu_map.png" alt="qU"/>
        </a>
      </div>
    </div>
  </li>
  <li style='background: rgba(210, 210, 210, 1.0)'>
    <div class='game'>
      <div class='gamedesc' style='align-self: flex-start'>
        <h1>Wavescape</h1>
        <h3>Roles: programmer, designer</h3>
        <p>&nbsp;&nbsp;<i class='fa fa-fw fa-arrow-right'></i> <a href="https://www.youtube.com/watch?v=ap_coff-fCg">trailer</a></p>
        <p>Wavescape is a game made in 48 hours for Global Game Jam 2017 by a team of 6 people, available for
        download <a href="https://globalgamejam.org/2017/games/wavescape-0">here</a>.</p>
        <p>It's a 2D puzzle game for Windows and Linux where you control the wave function of an ion
        trapped in a quantum computer. The ion follows its wave: change its shape to make it avoid
        the obstacles!</p>
        <p>I was mainly a gameplay programmer, but I also contributed to the game concept and helped
        design a level.</p>
      </div>
      <div class='game-imgs'>
        <a href='/assets/img/wavescape/wv_menu.png'>
          <img src="/assets/img/wavescape/wv_menu_small.png" alt="Wavescape"/>
        </a>
        <a href='/assets/img/wavescape/wv_lv1.png'>
          <img src="/assets/img/wavescape/wv_lv1_small.png" alt="Wavescape"/>
        </a>
        <a href='/assets/img/wavescape/wv_lv2.png'>
          <img src="/assets/img/wavescape/wv_lv2_small.png" alt="Wavescape"/>
        </a>
        <a href='/assets/img/wavescape/wv_lv3.png'>
          <img src="/assets/img/wavescape/wv_lv3_small.png" alt="Wavescape"/>
        </a>
        <a href='/assets/img/wavescape/wv_lv4.png'>
          <img src="/assets/img/wavescape/wv_lv4_small.png" alt="Wavescape"/>
        </a>
        <a href='/assets/video/wavescape/wv_gameplay.webm'>
          <img class='thumb' src="/assets/video/wavescape/wv_gameplay_thumb.png" alt="Wavescape"/>
          <video src="/assets/video/wavescape/wv_gameplay_small.webm" alt="Wavescape"/>
        </a>
      </div>
    </div>
  </li>
  <li style='background: rgba(220, 220, 220, 1.0)'>
    <div class='game'>
      <div class='gamedesc' style='align-self: flex-start'>
        <h1>Realtime Graphics Programming project [unnamed]</h1>
        <h3>Roles: programmer</h3>
        <p>A project made for a course in Realtime Graphics Programming by a team of 2 people.</p>
        <p>It's a toon-shaded "tech demo" viewable in browser where you make a small turtle swim in the ocean among floating barrels.</p>
        <p>Uses <a href="https://threejs.org/">THREE.js</a> as a WebGL helper and <a href="https://github.com/kripken/ammo.js/">Ammo.js</a>
        as Bullet Physics binding to Javascript.</p>
        <p>Both the barrels and the turtle are dynamic rigidbodies which collide and float through physics simulation.</p>
        <p>In this project, I wrote the physics simulation system (including the player's movement and the floating of
        objects) as well as most of the assets loading and initialization, which is mostly asynchronous.</p>
        <p>I used <a href="http://maxtaco.github.io/coffee-script/">Iced Coffeescript</a> to ease the writing of the
        numerous asynchronous parts of the code. The code is available <a href="https://github.com/silverweed/pgtr/">here</a>.</p>
      </div>
      <div class='game-imgs'>
        <a href='/assets/img/pgtr/pgtr1.png'>
          <img src="/assets/img/pgtr/pgtr1.png" alt="PGTR"/>
        </a>
        <a href='/assets/img/pgtr/pgtr2.png'>
          <img src="/assets/img/pgtr/pgtr2.png" alt="PGTR"/>
        </a>
        <a href='/assets/img/pgtr/pgtr3.png'>
          <img src="/assets/img/pgtr/pgtr3.png" alt="PGTR"/>
        </a>
        <a href='/assets/img/pgtr/pgtr4.png'>
          <img src="/assets/img/pgtr/pgtr4.png" alt="PGTR"/>
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
