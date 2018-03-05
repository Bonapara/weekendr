import Typed from 'typed.js';

function loadDynamicBannerText() {
  new Typed('#banner-typed-text', {
    strings: ["Madrid", "Athènes", "Rome", "Madrid", "Berlin", "Londres", "Porto"],
    typeSpeed: 50,
    backDelay: 2000,
    backSpeed: 50,
    fadeOutDelay: 500,
    showCursor: true,
    loop: true,
  });
}

export { loadDynamicBannerText };

