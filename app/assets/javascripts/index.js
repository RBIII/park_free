function initIndexMap() {
  var jsonMarkers = $("#index-map").data("jsonMarkers");
  var center = new google.maps.LatLng(42.339169, -71.088474);
  var bounds = new google.maps.LatLngBounds();
  var parkingAreas = [];

  map = new google.maps.Map(document.getElementById('index-map'), {
    center: center,
    zoom: 4
  });

  google.maps.event.addDomListener(window, 'load', getLocation());

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

  new MarkerClusterer(map, parkingAreas, {
    imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m',
    maxZoom: 10
  });

  google.maps.event.addListener(map, 'mousedown', function(event){
    sameCenter = true;
    google.maps.event.addListener(map, 'drag', function(){
      sameCenter = false;
    });
    var latLng = event.latLng;

    var counter = setTimeout(function(){
      setPressedLocationMarker(latLng);
    }, 1000);

    google.maps.event.addListener(map, 'mouseup', function(){
      clearTimeout(counter)
    });
  });
}
