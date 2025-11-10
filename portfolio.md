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
.a {
  background: rgba(210, 210, 210, 1.0);
}
.b {
  background: rgba(220, 220, 220, 1.0);
}
</style>

<ul class='gamelist'>
  <li style='background: rgba(250, 250, 250, 1.0)'>
    <div class="game">
      <div class="gamedesc right">
        <h1>About me</h1>
        <p>I like science, especially Physics.</p>
        <p>I like games, especially videogames.</p>
        <p>I like programming, especially game programming.</p>
        <p>Read more about me and what I do <a href="https://silverweed.github.io/about_this_blog_(and_its_author)">on my blog</a> if you're interested!</p>
      </div>
    </div>
  </li>
  <li class='a'>
    <div class='game'>
      <div class='gamedesc'>
        <h1>Lifish / BOOM Remake <small>(2015-2019)</h1>
        <h3>Roles: programmer, designer</h3>
        <p>Lifish was born in 2015 as a free software clone of an old Mac game called <em>BOOM</em>, 
        a "Bomberman meets Doom" arcade game. The source code is available
        <a href="https://codeberg.org/silverweed/lifish">here</a>.</p>
        <p>The project later evolved into an original game, preserving most original BOOM mechanics 
        while adding on bosses, enemies and powerups.</p>
        <p>As a <strong>programmer</strong>, I basically wrote the entire thing. Lifish uses a custom C++
        engine leveraging the <a href="https://www.sfml-dev.org/">SFML</a> multimedia library for
        multi-platform deployment (the game runs on Linux, Mac, Windows and FreeBSD).</p>
        <p>Lifish development is in hiatus, but I created a fork named 
        <a href="https://silverweed.github.io/boom/">BOOM: Remake</a> which is a 
        faithful recreation of the original <em>BOOM</em> available for free for Linux, Windows and Mac.</p>
      </div>
      <div class='game-imgs'>
        <a href='/assets/img/lifish/lifish_screen1.png'><img src="/assets/img/lifish/lifish_screen1.png" alt="Lifish"/></a>
        <a href='/assets/video/lifish/rex_atk.webm'>
          <img class="thumb" src="/assets/video/lifish/rex_atk_thumb.png" alt="Lifish"/>
          <video src="/assets/video/lifish/rex_atk.webm" alt="Lifish"></video>
        </a>
        <a href='/assets/img/lifish/lifish_lv11.png'><img src="/assets/img/lifish/lifish_lv11.png" alt="Lifish"/></a>
        <a href='/assets/img/lifish/lifish_lv30.png'><img src="/assets/img/lifish/lifish_lv30.png" alt="Lifish"/></a>
      </div>
    </div>
  </li>
  <li class='b'>
    <div class='game'>
      <div class='gamedesc' style='align-self: flex-start'>
        <h1>Haru <small>(2023)</small></h1>
        <p>&nbsp;&nbsp;<i class='fa fa-fw fa-arrow-right'></i> <a href="https://codeberg.org/silverweed/haru">source</a></p>
        <p>A rendering engine I'm writing in my free time, written in C++ and working on Linux and Windows.</p>
        <p>Uses GLFW for windowing and OpenGL 4.6 as a graphics backend.</p>
        <p>It's still early in development, but it currently features: (partial) GLTF models loading, multiple viewports and cameras, PBR, HDR, frustum culling using spheres, AABB and OBB, shadow mapping, custom memory allocators, ImGui-based user interface and various profiling views.</p>
        <p>Haru currently uses a deferred G-Buffer-based rendering pipeline, supporting an intederminate amount of lights through additive blending. My intention is to eventually switch to a visibility buffer approach.</p>
      </div>
      <div class='game-imgs'>
        <a href='/assets/img/haru/haru.png'>
          <img src="/assets/img/haru/haru_small.png" alt="Yes, I know, the Sponza again...I'll find some more original test models in the future, promised!"/>
        </a>
        <a href='/assets/img/haru/haru_viewports.png'>
          <img class="thumb" src="/assets/img/haru/haru_viewports_small.png" alt="Showcasing multiple viewports and debug visualizations."/>
        </a>
        <a href='/assets/img/haru/haru_lights.png'>
          <img class="thumb" src="/assets/img/haru/haru_lights_small.png" alt="Rendering about 100 lights"/>
        </a>
        <a href='/assets/img/haru/haru_shadows.png'>
          <img class="thumb" src="/assets/img/haru/haru_shadows_small.png" alt="Rendering shadows"/>
        </a>
      </div>
    </div>
  </li>
  <li class='a'>
    <div class='game'>
      <div class='gamedesc' style='align-self: flex-start'>
        <h1>Master Thesis: Distributed Rendering in Vulkan <small>(2018)</small></h1>
        <p>&nbsp;&nbsp;<i class='fa fa-fw fa-arrow-right'></i> <a href="https://codeberg.org/silverweed/thesis">source</a></p>
        <p>My Master Thesis project, written in C++14 using the Vulkan API. Runs on Linux and Windows.</p>
        <p>This project explores the concept of a “distributed rendering engine” for videogames with the aim to split the graphics
        pipeline between a server and a client. My goal is to create a hybrid model between  the "classic heavyweight
        client" model (where the client makes all the processing needed for rendering) and the more recent 
        "streaming" model
        (where the server does all the processing and sends the stream of rendered frames to the client).</p>
        <p>In my project, models, textures and shaders live on the server, which does most of the application-stage
        work. Then, rather than rendering models and sending frames to the client, it sends preprocessed geometry data
        to it, which in turn runs all the following pipeline stages.</p>
        <p>The rendering pipeline is a classic G-Buffer-based deferred pipeline.</p>
      </div>
      <div class='game-imgs'>
        <a href='/assets/img/thesis/thesis1.png'>
          <img src="/assets/img/thesis/thesis1_small.png" alt="Thesis"/>
        </a>
        <a href='/assets/img/thesis/thesis2.png'>
          <img src="/assets/img/thesis/thesis2_small.png" alt="Thesis"/>
        </a>
        <a href='/assets/video/thesis/thesis_tex_streaming.webm'>
          <img class='thumb' src='/assets/video/thesis/thesis_tex_streaming.png' alt='Thesis'/>
          <video src="/assets/video/thesis/thesis_tex_streaming_small.webm" alt="Thesis"></video>
        </a>
      </div>
    </div>
  </li>
  <li class='b'>
    <div class='game'>
      <div class='gamedesc' style='align-self: flex-start'>
        <h1>Gadget <small>(2018)</small></h1>
        <p>&nbsp;&nbsp;<i class='fa fa-fw fa-arrow-right'></i> <a href="https://codeberg.org/silverweed/gadget">source</a></p>
        <p>My first toy rendering engine, written (in a couple of months) as a way to get 
	a solid grasp on OpenGL and graphics programming.</p>
        <p>Gadget is written in D and uses OpenGL + SFML for windowing. It's only been tested on Linux.</p>
        <p>Features basic primitive drawing, instanced drawing,
        texturing, diffuse/specular/normal maps, ambient/directional/multiple point lights, 
	Blinn-Phong shading, shadow mapping and skybox drawing.</p>
        <p>I wrote a couple of posts about Gadget <a href="https://silverweed.github.io/tags/#gadget">on my blog</a>.</p>
      </div>
      <div class='game-imgs'>
        <a href='/assets/img/gadget/cubes.png'>
          <img src="/assets/img/gadget/cubes_small.png" alt="Gadget"/>
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
          <img src="/assets/img/gadget/gadget_screen1_small.png" alt="Gadget"/>
        </a>
      </div>
    </div>
  </li>
  <li class='a'>
    <div class='game'>
      <div class='gamedesc' style='align-self: flex-start'>
        <h1>GIVE - I Guardiani Del Corpo <small>(2016-2017)</small></h1>
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
          <img src="/assets/img/give/give_gameplay1_small.png" alt="GIVE"/>
        </a>
        <a href='/assets/video/give/buddy_boss_lv1.mp4'>
          <img class="thumb" src="/assets/video/give/buddy_boss_lv1_thumb.png" alt="GIVE"/>
          <video src="/assets/video/give/buddy_boss_small.webm" alt="GIVE"></video>
        </a>
        <a href='/assets/img/give/boss_lv3.png'>
          <img src="/assets/img/give/boss_lv3.png" alt="GIVE"/>
        </a>
        <a href='/assets/img/give/nuke_explosion.png'>
          <img src="/assets/img/give/nuke_explosion_small.png" alt="GIVE"/>
        </a>
        <a href='/assets/img/give/give_selection.png'>
          <img src="/assets/img/give/give_selection_small.png" alt="GIVE"/>
        </a>
        <a href='/assets/video/give/tiny.mp4'>
          <img class="thumb" src="/assets/video/give/tiny_thumb.png" alt="GIVE"/>
          <video src="/assets/video/give/tiny_small.webm" alt="GIVE"></video>
        </a>
      </div>
    </div>
  </li>
  <li class='b'>
    <div class='game'>
      <div class='gamedesc' style='align-self: flex-start'>
        <h1>Hacknid <small>(2019)</small></h1>
        <h3>Roles: gameplay, shader and tool programmer</h3>
        <p>&nbsp;&nbsp;<i class='fa fa-fw fa-arrow-right'></i> <a href="https://www.youtube.com/watch?v=cNoHH2No_1M&index=60&list=PL4QF7lP4PZkBYflnk-bkJd_fs57Exw-YN">trailer</a></p>
        <p>Hacknid is a game made in 48 hours for Global Game Jam 2018 by a team of 4 people, available for
        download <a href="https://ggj.s3.amazonaws.com/games/2018/01/146096/exec/58jXE/Hacknid.zip">here</a>. You can also 
        <a href="https://silverweed.github.io/hacknid-play/">play it in your browser</a> (you'll need mouse+keyboard or
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
          <img src="/assets/img/hacknid/hacknid_gameplay1_small.png" alt="Hacknid"/>
        </a>
        <a href='/assets/video/hacknid/hacknid_gameplay.webm'>
          <img class='thumb' src="/assets/video/hacknid/hacknid_gameplay_small.png" alt="Hacknid"/>
          <video src="/assets/video/hacknid/hacknid_gameplay_small.webm" alt="Hacknid"></video>
        </a>
        <a href='/assets/img/hacknid/hacknid_menu.png'>
          <img src="/assets/img/hacknid/hacknid_menu_small.png" alt="Hacknid"/>
        </a>
        <a href='/assets/img/hacknid/hacknid_gameplay2.png'>
          <img src="/assets/img/hacknid/hacknid_gameplay2_small.png" alt="Hacknid"/>
        </a>
        <a href='/assets/img/hacknid/hacknid_gameplay3.png'>
          <img src="/assets/img/hacknid/hacknid_gameplay3_small.png" alt="Hacknid"/>
        </a>
        <a href='/assets/video/hacknid/hacknid_gameplay2.webm'>
          <img class='thumb' src="/assets/video/hacknid/hacknid_gameplay2_small.png" alt="Hacknid"/>
          <video src="/assets/video/hacknid/hacknid_gameplay2_small.webm" alt="Hacknid"></video>
        </a>
      </div>
    </div>
  </li>
  <li class='a'>
    <div class='game'>
      <div class='gamedesc' style='align-self: flex-start'>
        <h1>qU <small>(2017)</small></h1>
        <h3>Roles: programmer</h3>
        <p>&nbsp;&nbsp;<i class='fa fa-fw fa-arrow-right'></i> <a href="https://github.com/qu-team/QuPrototype">source</a></p>
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
  <li class='b'>
    <div class='game'>
      <div class='gamedesc' style='align-self: flex-start'>
        <h1>Wavescape <small>(2017)</small></h1>
        <h3>Roles: programmer, designer</h3>
        <p>&nbsp;&nbsp;<i class='fa fa-fw fa-arrow-right'></i> <a href="https://www.youtube.com/watch?v=ap_coff-fCg">trailer</a></p>
        <p>&nbsp;&nbsp;<i class='fa fa-fw fa-arrow-right'></i> <a href="https://codeberg.org/silverweed/ggj17">source</a></p>
        <p>Wavescape is a game made in 48 hours for Global Game Jam 2017 by a team of 6 people, available for
        download <a href="https://ggj.s3.amazonaws.com/games/2017/01/22/1729/wavescape_win_linux.zip">here</a>.</p>
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
          <video src="/assets/video/wavescape/wv_gameplay_small.webm" alt="Wavescape"></video>
        </a>
      </div>
    </div>
  </li>
  <li class='a'>
    <div class='game'>
      <div class='gamedesc' style='align-self: flex-start'>
        <h1>Realtime Graphics Programming project <small>(2017)</small></h1>
        <h3>Roles: programmer</h3>
        <p>&nbsp;&nbsp;<i class='fa fa-fw fa-arrow-right'></i> <a href="https://codeberg.org/silverweed/pgtr">source</a></p>
        <p>A project made for a course in Realtime Graphics Programming by a team of 2 people.</p>
        <p>It's a toon-shaded "tech demo" viewable in browser where you make a small turtle swim in the ocean among floating barrels.</p>
        <p>Uses <a href="https://threejs.org/">THREE.js</a> as a WebGL helper and <a href="https://github.com/kripken/ammo.js/">Ammo.js</a>
        as Bullet Physics binding to Javascript.</p>
        <p>Both the barrels and the turtle are dynamic rigidbodies which collide and float through physics simulation.</p>
        <p>In this project, I wrote the physics simulation system (including the player's movement and the floating of
        objects) as well as most of the assets loading and initialization, which is mostly asynchronous.</p>
        <p>I used <a href="http://maxtaco.github.io/coffee-script/">Iced Coffeescript</a> to ease the writing of the
        numerous asynchronous parts of the code.</p>
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
  <li class='b'>
    <div class='game'>
      <div class='gamedesc' style='align-self: flex-start'>
        <h1>Blockster <small>(2019)</small></h1>
        <h3>Roles: programmer, designer</h3>
        <p>&nbsp;&nbsp;<i class='fa fa-fw fa-arrow-right'></i> <a href="https://www.youtube.com/watch?v=d_ngjdZGyxI">trailer</a></p>
        <p>&nbsp;&nbsp;<i class='fa fa-fw fa-arrow-right'></i> <a href="https://codeberg.org/silverweed/ggj19">source</a></p>
        <p>Blockster is a game made in 48 hours for Global Game Jam 2019 by a team of 4 people, available for
        download <a href="https://silverweed91.itch.io/blockster">here</a>.</p>
        <p>It's a frenetic 1v1 arena brawler for Windows and Linux where your goal is to reach your opponent's house
        while preventing him/her to do the same. There's also a kill counter for fun and profit! </p>
        <p>I was mainly a gameplay programmer, but I also contributed to the game concept.</p>
      </div>
      <div class='game-imgs'>
        <a href='/assets/img/blockster/blockster_featured.png'>
          <img src="/assets/img/blockster/blockster_featured_small.png" alt="Blockster"/>
        </a>
        <a href='/assets/img/blockster/blockster_1.png'>
          <img src="/assets/img/blockster/blockster_1_small.png" alt="Blockster"/>
        </a>
        <a href='/assets/img/blockster/blockster_4.png'>
          <img src="/assets/img/blockster/blockster_4_small.png" alt="Blockster"/>
        </a>
        <a href='/assets/img/blockster/blockster_2.png'>
          <img src="/assets/img/blockster/blockster_2_small.png" alt="Blockster"/>
        </a>
        <a href='/assets/video/blockster/blockster_gameplay.webm'>
          <img class='thumb' src="/assets/video/blockster/blockster_gameplay_thumb.png" alt="Blockster"/>
          <video src="/assets/video/blockster/blockster_gameplay_small.webm" alt="Blockster"></video>
        </a>
      </div>
    </div>
  </li>
  <li class='a'>
    <div class='game'>
      <div class='gamedesc' style='align-self: flex-start'>
        <h1>Automaton <small>(2020)</small></h1>
        <h3>Roles: programmer</h3>
        <p>&nbsp;&nbsp;<i class='fa fa-fw fa-arrow-right'></i> <a href="https://www.youtube.com/watch?v=RkuEjaRWawE">trailer</a></p>
        <p>&nbsp;&nbsp;<i class='fa fa-fw fa-arrow-right'></i> <a href="https://codeberg.org/silverweed/ggj20">source</a></p>
        <p>Automaton is a game made in 48 hours for Global Game Jam 2020 by a team of 4 people.</p>
        <p>It's a text-based, Oregon Trail-like adventure settled in the far future. Play as a roaming automaton,
        tredding the land and attempting to mend itself, the humans it comes across and the planet.</p>
        <p>The game is event-based and all events are written in text files with a simple format,
        so the game can be easily modded without the need of recompiling the game.</p>
        <p>I was the main programmer on the game, wrote the events parser and contributed some ideas to the game concept.</p>
      </div>
      <div class='game-imgs'>
        <a href='/assets/img/automaton/automaton_gameplay.png'>
          <img src="/assets/img/automaton/automaton_gameplay_small.png" alt="Automaton"/>
        </a>
        <a href='/assets/img/automaton/automaton_title_screen.png'>
          <img src="/assets/img/automaton/automaton_title_screen_small.png" alt="Automaton"/>
        </a>
        <a href='/assets/video/automaton/automaton_gameplay.webm'>
          <img class='thumb' src="/assets/video/automaton/automaton_gameplay_thumb.png" alt="Automaton"/>
          <video src="/assets/video/automaton/automaton_gameplay_small.webm" alt="Automaton"></video>
        </a>
      </div>
    </div>
  </li>
  <li class='b'>
    <div class='game'>
      <div class='gamedesc' style='align-self: flex-start'>
        <h1>Inle Engine <small>(2018-2022)</small></h1>
        <h3>Roles: programmer, designer</h3>
        <p>&nbsp;&nbsp;<i class='fa fa-fw fa-arrow-right'></i> <a href="https://codeberg.org/silverweed/ecsde">source</a></p>
        <p>Inle is a 2D toy game engine based on ECS and written in Rust.</p>
        <p>It features an OpenGL-based renderer, MSDF font rendering, simple 2D collisions based on impulse resolution, data and code hot-reloading and various debugging facilities, including a built-in tracing profiler and a console with autocompletion and better user input handling than Unreal's :-)</p>
        <p>It was built with as few dependencies as possible, the biggest dependency being SFML for windowing. It runs on Linux and Windows.</p>
        <p>The engine is still in development, with the goal of using it in an actual game at some point.</p>
      </div>
      <div class='game-imgs'>
        <a href='/assets/img/inle/inle1.png'>
          <img src="/assets/img/inle/inle1_small.png" alt="Inle"/>
        </a>
        <a href='/assets/img/inle/inle_console.png'>
          <img src="/assets/img/inle/inle_console_small.png" alt="In-game console in Inle engine"/>
        </a>
        <a href='/assets/video/inle/inle_prof.mp4'>
          <img class='thumb' src="/assets/video/inle/inle_prof_small.png" alt="Profiling tools in Inle engine"/>
          <video src="/assets/video/inle/inle_prof_small.webm" alt="Profiling tools in Inle engine"></video>
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
