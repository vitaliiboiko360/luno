const images = [
  'daniel-meyer.jpg',
  'dan-meyers.jpg',
  'davide-longo.jpg',
  'denver-saldanha.jpg',
  'fabrizio-conti.jpg',
  'justin-luebke.jpg',
  'lake-tahoe-boat.jpg',
  'luca-bravo.jpg',
  'marek-okon.jpg',
  'marek-piwnicki.jpg',
  'pascal-debrunner.jpg',
  'silas-baisch.jpg',
  'vedant-sonani.jpg',
];
(function () {
  const randIndex = ~~(Math.random() * images.length);
  const body = document.body;
  body.style.backgroundImage = `url('bg/${images[randIndex]}')`;
})();
