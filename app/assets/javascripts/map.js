var map;
var currentLocation = null;
var newParkingArea = null;
var openWindow = null;

function calcRoute(destinationLat, destinationLng) {
  //What: gives directions to the input parking area
  //When: the directions button is clicked
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

    if (openWindow != null) {
      openWindow.close();
      openWindow = null;
    }
  } else {
    alert("You must have location enabled for directions")
    getLocation();
  };
};

function displayOnMap(position) {
  //What: adds a marker at a the users current location
  //When: their coordinate location is obtained
  var latLng = {lat: position.coords.latitude, lng: position.coords.longitude}
  var accuracy = position.coords.accuracy
  currentLocationInfowindow = new google.maps.InfoWindow({
    content: '<button onclick=addParkingArea() class="button" style="margin-bottom: 0px;">Add Parking Area</button>'
  });

  currentLocation = new google.maps.Marker({
    position: latLng,
    map: map,
    title: 'My Location'
  });

  google.maps.event.addListener(currentLocation, 'click', function(object){
    currentLocationInfowindow.open(map, currentLocation);
  });
}

function addParkingArea() {
  //What: adds a parking area from either a long pressed location or the users current location
  //When: the 
  $.ajax({
      type : "POST",
      url : "/parking_areas/redirect_to_new_from_map.js",
      dataType: 'script',
      data : { lat: newParkingArea.position.lat(), lng: newParkingArea.position.lng() }
  });
}

function setPressedLocationMarker(latLng) {
  if (sameCenter) {
    newParkingAreaInfoWindow = new google.maps.InfoWindow({
      content: '<button onclick=addParkingArea() class="button" style="margin-bottom: 0px;">Add Parking Area</button>'
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

    google.maps.event.addListener(newParkingArea, 'click', function() {
      newParkingAreaInfoWindow.open(map, newParkingArea);
    });

    setTimeout(function() {
      newParkingAreaInfoWindow.open(map, newParkingArea);
    }, 750);

    google.maps.event.addListener(newParkingAreaInfoWindow, 'closeclick', function() {
      if(newParkingArea != null) {
        newParkingArea.setMap(null);
        newParkingArea = null
      }
    });
  }
}

function getLocation() {
  //What: gets the current location of the user
  //When: the site is opened
  if (navigator.geolocation) {
    navigator.geolocation.watchPosition(displayOnMap,
       function error(msg){ alert('Please enable your GPS postion feature');
    }, {maximumAge:Infinity, timeout:60000, enableHighAccuracy: true});
  } else {
    alert("Geolocation API is not enabled in your browser.");
  }
}

function closeOtherWindows() {
  //What: closes all other windows
  //When: another marker is clicked
  if (currentLocation != null) currentLocationInfowindow.close();
  if (newParkingArea != null) newParkingAreaInfoWindow.close();
  if (openWindow != null) openWindow.close();
}

function closeWindow() {
  //What: closes the current open infowindow
  //When: any area that doesn't have an 'onClick' function is clicked
  openWindow.close();
  openWindow = null;
}
