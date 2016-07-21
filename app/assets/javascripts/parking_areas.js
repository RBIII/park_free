// handler = Gmaps.build('Google');
//
// handler.buildMap({ provider: {}, internal: {id: 'multi_markers'}}, function(){
//   markers = handler.addMarkers(<%= raw @json_fpas.to_json %>);
//
//   if(navigator.geolocation) {
//     navigator.geolocation.getCurrentPosition(displayOnMap)
//   };
//
//   handler.map.centerOn(centerpoint)
//   handler.bounds.extendWith(markers);
//   handler.getMap().setZoom(12);
// });
// var map = handler.getMap();
var map;

function initMap() {
  let json_markers = $("#index-map").data("json_markers")
  let centerpoint = new google.maps.LatLng(42.339169, -71.088474);

  map = new google.maps.Map(document.getElementById('index-map'), {
    center: centerpoint,
    zoom: 12
  });

  for (json_marker in json_markers) {
    
  }


  google.maps.event.addListener(map, 'mousedown', function(event){
    var pressedLocationInfowindow=new google.maps.InfoWindow({
      content: '<button onclick=addPressedLocation()>Add Parking Area</button>'
    });

    var counter=setTimeout(timer, 2200);
    var latLng=event.latLng;

    google.maps.event.addListener(map, 'mouseup', function(){
      clearTimeout(counter)
    });

    function timer(){
      if (gon.new_parking_area.length == 0){
        var marker = new google.maps.Marker({
          position: latLng,
          map: map,
          draggable: true,
          icon: "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|C3BDBD|000000"
        });

          gon.new_parking_area.push(marker);
          pressedLocationInfowindow.open(map, marker);

          google.maps.event.addListener(pressedLocationInfowindow,'closeclick',function(){
            if(gon.new_parking_area.length > 0){
              gon.new_parking_area[0].setMap(null);
              gon.new_parking_area.pop();
            }
          });
  } else {
    gon.new_parking_area[0].setPosition(latLng);
      }
    }
  });
}

function displayOnMap(position){
  var currentLocationInfowindow=new google.maps.InfoWindow({
    content: '<button onclick=addCurrentLocation()>Add Parking Area</button>'
  });

  var marker = new google.maps.Marker({
    position: myLatLng,
    map: map,
    title: 'Hello World!'
  });

  // var marker = handler.addMarker({
  //   lat: position.coords.latitude,
  //   lng: position.coords.longitude
  // });
  gon.current_location.push(marker)

  google.maps.event.addListener(marker.getServiceObject(), 'click', function(object){
    currentLocationInfowindow.open(map, marker.getServiceObject());
  });
};

function addPressedLocation(){
  $.ajax({
      type : "POST",
      url : "/free_parking_areas/redirect_to_new_from_map.js",
      dataType: 'script',
      data : { lat: gon.new_parking_area[0].position.lat(), lng: gon.new_parking_area[0].position.lng() }
  });
  return false;
}

function addCurrentLocation(){
  $.ajax({
      type : "POST",
      url : "/free_parking_areas/redirect_to_new_from_map.js",
      dataType: 'script',
      data : { lat: gon.current_location[0].getServiceObject().position.lat(), lng: gon.current_location[0].getServiceObject().position.lng() }
  });
  return false;
}

function calcRoute(destinationLat, destinationLng) {
  var directionsService = new google.maps.DirectionsService();
  var directionsDisplay = new google.maps.DirectionsRenderer({suppressMarkers:true});

  directionsDisplay.setMap(map)
  if(gon.current_location.length > 0) {
     var destination = new google.maps.LatLng(destinationLat, destinationLng);

     var request = {
         origin: gon.current_location[0].getServiceObject().position,
         destination: destination,
         travelMode:  google.maps.DirectionsTravelMode.DRIVING
     };
     directionsService.route(request, function(response, status) {
       if (status == google.maps.DirectionsStatus.OK) {
         directionsDisplay.setDirections(response);
       };
     });
    } else {
      alert("You must have location enabled for directions")
    };
  };

  function gmaps4rails_callback() {
    function closeInfowindows(){
      if(gon.new_parking_area.length > 0){
        debugger;
        gon.new_parking_area[0].setMap(null);
        gon.new_parking_area.pop();
      }
    }

    for (var i = 0; i <  Gmaps4Rails.markers.length; ++i) {
      debugger;

      google.maps.event.addListener(Gmaps4Rails.markers[i].google_object, 'click', closeInfowindows());
    }
  }
