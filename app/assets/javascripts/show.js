function initShowMap() {
  var jsonMarker = $("#map").data("jsonMarker")[0]
  var center = new google.maps.LatLng(jsonMarker.lat, jsonMarker.lng);
  map = createMap(center, 14)
  var infowindow = new google.maps.InfoWindow({
    content: jsonMarker.infowindow
  });

  var marker = new google.maps.Marker({
    position: center,
    map: map,
    icon: jsonMarker.picture,
    title: "Show Marker"
  });

  marker.addListener('click', function() {
    infowindow.open(map, marker);
  });

  google.maps.event.addDomListener(window, 'load', getCurrentLocation(map));

  setClickListener(map)
}
