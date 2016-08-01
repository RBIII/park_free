var map;
var currentLocation = null;
var newParkingArea = null;

function initMap() {
  if ($("#index-map").data("jsonMarkers")) {
    
    initIndexMap();
  } else if ($("#show-map").data("jsonMarker")) {
    initShowMap();
  }
}

function calcRoute(destinationLat, destinationLng) {
  var directionsService = new google.maps.DirectionsService();
  var directionsDisplay = new google.maps.DirectionsRenderer({suppressMarkers:true});

  directionsDisplay.setMap(map)
  if (currentLocation != null) {
    var destination = new google.maps.LatLng(destinationLat, destinationLng);

    var request = {
      origin: currentLocation.position,
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

function displayOnMap(position) {
  let latLng = {lat: position.coords.latitude, lng: position.coords.longitude}
  let currentLocationInfowindow = new google.maps.InfoWindow({
    content: '<button onclick=addCurrentLocation()>Add Parking Area</button>'
  });

  currentLocation = new google.maps.Marker({
    position: latLng,
    map: map,
    title: 'My Location'
  });

  google.maps.event.addListener(currentLocation, 'click', function(object){
    currentLocationInfowindow.open(map, currentLocation);
  });
};

function addCurrentLocation() {
  $.ajax({
      type : "POST",
      url : "/parking_areas/redirect_to_new_from_map.js",
      dataType: 'script',
      data : { lat: currentLocation.position.lat(), lng: currentLocation.position.lng() }
  });
}

function addNewParkingArea() {
  $.ajax({
      type : "POST",
      url : "/parking_areas/redirect_to_new_from_map.js",
      dataType: 'script',
      data : { lat: newParkingArea.position.lat(), lng: newParkingArea.position.lng() }
  });
}

function timer(latLng, centerPoint) {
  if (centerPoint == map.getCenter()) {
    let newParkingAreaInfoWindow = new google.maps.InfoWindow({
      content: '<button onclick=addNewParkingArea()>Add Parking Area</button>'
    });

    if (newParkingArea == null) {
      newParkingArea = new google.maps.Marker({
        position: latLng,
        map: map,
        draggable: true,
        animation: google.maps.Animation.DROP,
        icon: "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|C3BDBD|000000"
      });
    } else {
      newParkingArea.setPosition(latLng);
    }

    setTimeout(function() {
      newParkingAreaInfoWindow.open(map, newParkingArea);
    }, 700);

    google.maps.event.addListener(newParkingAreaInfoWindow, 'closeclick', function() {
      if(newParkingArea != null) {
        newParkingArea.setMap(null);
        newParkingArea = null
      }
    });
  }
}
