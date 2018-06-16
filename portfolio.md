---
layout: default 
title: silverweed's portfolio
permalink: /portfolio/
---

<style>
li {
	margin-bottom: 1px !important;
}
h2 {
	margin-top: 0;
}
div.game {
	display: flex;
  flex-direction: row;
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
  max-width: 40%;
}
.game-imgs a {
  position: relative;
}
.game-imgs img, video {
  width: 300px;
  height: auto;
  max-width: 100%;
  display: block;
}
.game-imgs img.play {
  width: 50%;
  position: absolute;
  opacity: 0.8;
  left: 35%;
  top: 16%;
}
.right {
  justify-content: flex-end;
}
</style>

<ul class='gamelist'>
  <li style='background: rgba(210, 210, 210, 1.0)'>
    <div class='game'>
      <div class='game-imgs'>
        <a href='/assets/img/lifish_screen1.png'><img src="/assets/img/lifish_screen1.png" alt="Lifish"/></a>
        <a href='/assets/video/rex_atk.webm'>
          <video src="/assets/video/rex_atk.webm" alt="Lifish" muted></video>
        </a>
        <a href='/assets/img/lifish_screen1.png'><img src="/assets/img/lifish_screen1.png" alt="Lifish"/></a>
        <a href='/assets/img/lifish_screen1.png'><img src="/assets/img/lifish_screen1.png" alt="Lifish"/></a>
      </div>
      <div class='gamedesc'>
        <h1>Lifish</h1>
        <p>An old-style arcade game about bombing aliens. Currently under development.</p>
      </div>
    </div>
  </li>
  <li style='background: rgba(210, 210, 210, 1.0)'>
    <div class='game right'>
      <div class='gamedesc' style='align-self: flex-start'>
        <h1>Lifish</h1>
        <p>An old-style arcade game about bombing aliens. Currently under development.</p>
      </div>
      <div class='game-imgs'>
        <a href='/assets/img/lifish_screen1.png'><img src="/assets/img/lifish_screen1.png" alt="Lifish"/></a>
        <a href='/assets/video/rex_atk.webm'>
          <video src="/assets/video/rex_atk.webm" alt="Lifish" muted style="position:relative"></video>
        </a>
        <img src="/assets/img/lifish_screen1.png" alt="Lifish"/>
        <img src="/assets/img/lifish_screen1.png" alt="Lifish"/>
      </div>
    </div>
  </li>
</ul>

<script>
document.querySelectorAll('video').forEach(video => {
  // Add play symbol
  var play = document.createElement('img');
  play.src='/assets/img/play.svg';
  play.className = 'play';
  var bound = video.getBoundingClientRect();
  video.parentNode.appendChild(play);

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
</script>
