let isPlaying = true;
let timeout
let display = 5;

function clearCurrent() {
  const currentAnnouncement = document.getElementById(`tw-announcement${display}`);
  currentAnnouncement.classList.remove('tw-announcement-visible');
  currentAnnouncement.classList.add('tw-announcement-hidden');
  currentAnnouncement.classList.remove('w3-animate-bottom');
}

function displayNew() {
  console.log(`display = ${display}`);
  const newAnnouncement = document.getElementById(`tw-announcement${display}`);
  console.log(newAnnouncement);
  newAnnouncement.classList.remove('tw-announcement-hidden');
  newAnnouncement.classList.add('w3-animate-bottom');
  newAnnouncement.classList.add('tw-announcement-visible');
}

function nextThing(goForward) {
  clearCurrent();
  display = display === 5 ? 1 : display + 1;
  displayNew();
  if (goForward) {
    timeout = setTimeout(() => { nextThing(true) }, 5000);
  }
}

if (window.attachEvent) {
  window.attachEvent('onload', () => { nextThing(true) });
} else {
  if (window.onload) {
    var curronload = window.onload;
    var newonload = function (evt) {
      curronload(evt);
      nextThing(true);
    };
    window.onload = newonload;
  } else {
    window.onload = () => { nextThing(true) };
  }
}


function goLeft() {
  pause();
  clearCurrent();
  display = display === 1 ? 5 : display - 1;
  displayNew();
}

function play() {
  const playPause = document.getElementById('tw-play-pause');
  playPause.classList.remove('tw-play');
  playPause.classList.add('tw-pause');
  isPlaying = true;
  nextThing(true);
}

function pause() {
  const playPause = document.getElementById('tw-play-pause');
  playPause.classList.remove('tw-pause');
  playPause.classList.add('tw-play');
  isPlaying = false;
  if (timeout) {
    clearTimeout(timeout);
  }
}

function playPause() {
  if (isPlaying) {
    pause();
  } else {
    play();
  }
}

function goRight() {
  if (timeout) {
    pause();
  }
  nextThing(false);
}
