function initShowMap() {
  var jsonMarker = $("#show-map").data("jsonMarker")[0]
  var centerpoint = new google.maps.LatLng(jsonMarker.lat, jsonMarker.lng);

  map = new google.maps.Map(document.getElementById('show-map'), {
    center: centerpoint,
    zoom: 14
  });

  var infowindow = new google.maps.InfoWindow({
    content: jsonMarker.infowindow
  });

  var marker = new google.maps.Marker({
    position: centerpoint,
    map: map,
    icon: jsonMarker.picture,
    title: "Show Marker"
  });

  marker.addListener('click', function() {
    infowindow.open(map, marker);
  });

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(displayOnMap)
  };

  google.maps.event.addListener(map, 'mousedown', function(event){
    sameCenter = true;
    google.maps.event.addListener(map, 'drag', function(){
      sameCenter = false;
    });
    var latLng = event.latLng;
    var counter = setTimeout(function(){
      setPressedLocationMarker(latLng);
    }, 1200);

    google.maps.event.addListener(map, 'mouseup', function(){
      clearTimeout(counter)
    });
  });
}
