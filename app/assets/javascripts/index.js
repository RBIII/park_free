function initIndexMap() {
  var jsonMarkers = $("#index-map").data("jsonMarkers");
  var center = new google.maps.LatLng(42.339169, -71.088474);
  var bounds = new google.maps.LatLngBounds();

  map = new google.maps.Map(document.getElementById('index-map'), {
    center: center,
    zoom: 12
  });

  for (var i = 0; i <  jsonMarkers.length; ++i) {
    (function() {
      var latLng = {lat: jsonMarkers[i].lat, lng: jsonMarkers[i].lng};
      var infowindow = new google.maps.InfoWindow({
        content: jsonMarkers[i].infowindow
        //, disableAutoPan: true
      });

      var marker = new google.maps.Marker({
        position: latLng,
        map: map,
        icon: jsonMarkers[i].picture
      });

      marker.addListener('click', function() {
        closeOtherWindows();
        openWindow = infowindow;
        infowindow.open(map, marker);
      });

      bounds.extend(marker.getPosition());
    })();
  }

  // map.fitBounds(bounds)

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

  google.maps.event.addDomListener(window, 'load', getLocation);
}
