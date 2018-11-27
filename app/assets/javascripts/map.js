function map(key) {
mapboxgl.accessToken = key
var map = new mapboxgl.Map({
    container: 'map', // container id
    style: 'mapbox://styles/mapbox/streets-v9', // stylesheet location
    center: [-90, 38], // starting position [lng, lat]
    zoom: 4 // starting zoom
});
}
