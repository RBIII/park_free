function initShowMap() {
  let jsonMarker = $("#show-map").data("jsonMarker")[0]
  let centerpoint = new google.maps.LatLng(jsonMarker.lat, jsonMarker.lng);

  map = new google.maps.Map(document.getElementById('show-map'), {
    center: centerpoint,
    zoom: 14
  });

  let infowindow = new google.maps.InfoWindow({
    content: jsonMarker.infowindow
  });

  let marker = new google.maps.Marker({
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
    let latLng = event.latLng;
    let centerPoint = map.getCenter()
    var counter = setTimeout(function(){
      timer(latLng, centerPoint);
    }, 1500);

    google.maps.event.addListener(map, 'mouseup', function(){
      clearTimeout(counter)
    });
  });
}
