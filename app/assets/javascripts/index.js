function initIndexMap() {
  let jsonMarkers = $("#index-map").data("jsonMarkers");
  let centerPoint = new google.maps.LatLng(42.339169, -71.088474);
  var bounds = new google.maps.LatLngBounds();

  map = new google.maps.Map(document.getElementById('index-map'), {
    center: centerPoint,
    zoom: 12
  });

  for (var i = 0; i <  jsonMarkers.length; ++i) {
    let latLng = {lat: jsonMarkers[i].lat, lng: jsonMarkers[i].lng}
    let infowindow = new google.maps.InfoWindow({
      content: jsonMarkers[i].infowindow
    });

    let marker = new google.maps.Marker({
      position: latLng,
      map: map,
      icon: jsonMarkers[i].picture
    });

    marker.addListener('click', function() {
      infowindow.open(map, marker);
    });

    bounds.extend(marker.getPosition())
  }

  // map.fitBounds(bounds)

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(displayOnMap)
  };

  google.maps.event.addListener(map, 'mousedown', function(event){
    let latLng = event.latLng;
    let centerPoint = map.getCenter();
    var counter = setTimeout(function(){
      timer(latLng, centerPoint);
    }, 1500);

    google.maps.event.addListener(map, 'mouseup', function(){
      clearTimeout(counter)
    });
  });
}

  function gmaps4rails_callback() {
    function closeInfowindows(){
      if(newParkingArea != null){
        newParkingArea.setMap(null);
        newParkingArea = null;
      }
    }

    for (var i = 0; i <  Gmaps4Rails.markers.length; ++i) {

      google.maps.event.addListener(Gmaps4Rails.markers[i].google_object, 'click', closeInfowindows());
    }
  }
