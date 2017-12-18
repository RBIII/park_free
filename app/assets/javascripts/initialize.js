function initMap() {
  var jsonMarkers = $("#map").data("jsonMarkers");
  if (jsonMarkers.length == 1) {
    var center = new google.maps.LatLng(jsonMarkers[0].lat, jsonMarkers[0].lng);
  } else {
    var center = new google.maps.LatLng(42.339169, -71.088474);
  }
  var bounds = new google.maps.LatLngBounds();
  var parkingAreas = [];

  map = createMap(center, 4)

  google.maps.event.addDomListener(window, 'load', getCurrentLocation(map));

  for (var i = 0; i <  jsonMarkers.length; ++i) {
    (function() {
      var latLng = {lat: jsonMarkers[i].lat, lng: jsonMarkers[i].lng};
      var infowindow = new google.maps.InfoWindow({
        content: jsonMarkers[i].infowindow
      });

      var marker = new google.maps.Marker({
        position: latLng,
        map: map,
        icon: jsonMarkers[i].picture,
        label: jsonMarkers[i].title
      });


      marker.addListener('click', function() {
        closeOtherWindows();
        openWindow = infowindow;
        infowindow.open(map, marker);
      });

      parkingAreas.push(marker);

      bounds.extend(marker.getPosition());
    })();
  }

  if (jsonMarkers.length > 1 ) {
    new MarkerClusterer(map, parkingAreas, {
      imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m',
      maxZoom: 6
    });
  }

  setClickListener(map)
}
