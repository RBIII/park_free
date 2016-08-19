var map;
var currentLocation = null;
var newParkingArea = null;
var openWindow = null;

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
//   if (navigator.geolocation) {
//     navigator.geolocation.getCurrentPosition(function(position){
//     var latitude = position.coords.latitude;
//     var longitude = position.coords.longitude;
//     var accuracy = position.coords.accuracy;
//     var coords = new google.maps.LatLng(latitude, longitude);
//     var mapOptions = {
//         zoom: 15,
//         center: coords,
//         mapTypeControl: true,
//         navigationControlOptions: {
//             style: google.maps.NavigationControlStyle.SMALL
//         },
//         mapTypeId: google.maps.MapTypeId.ROADMAP
//         };
//
//      var capa = document.getElementById("capa");
//      capa.innerHTML = "latitud: " + latitude + " longitud: " + "   aquesta es la precisio en metres  :  " + accuracy;
//
//         map = new google.maps.Map(
//             document.getElementById("mapContainer"), mapOptions
//             );
//         var marker = new google.maps.Marker({
//                 position: coords,
//                 map: map,
//                 title: "ok"
//         });
//
//
//     },function error(msg){alert('Please enable your GPS position future.');
//
//   }, {maximumAge:600000, timeout:5000, enableHighAccuracy: true});
//
// }else {
//     alert("Geolocation API is not supported in your browser.");
// }

  var latLng = {lat: position.coords.latitude, lng: position.coords.longitude}
  var accuracy = position.coords.accuracy
  currentLocationInfowindow = new google.maps.InfoWindow({
    content: '<button onclick=addCurrentLocation() class="button" style="margin-bottom: 0px;">Add Parking Area</button>'
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

function setPressedLocationMarker(latLng) {
  if (sameCenter) {
    newParkingAreaInfoWindow = new google.maps.InfoWindow({
      content: '<button onclick=addNewParkingArea() class="button" style="margin-bottom: 0px;">Add Parking Area</button>'
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
  if (navigator.geolocation) {
    navigator.geolocation.watchPosition(displayOnMap,
       function error(msg){ alert('Please enable your GPS postion feature');
    }, {maximumAge:Infinity, timeout:60000, enableHighAccuracy: true});
  } else {
    alert("Geolocation API is not enabled in your browser.");
  }
}

function closeOtherWindows() {
  if (currentLocation != null) currentLocationInfowindow.close();
  if (newParkingArea != null) newParkingAreaInfoWindow.close();
  if (openWindow != null) openWindow.close();
}

function closeWindow() {
  openWindow.close();
  openWindow = null;
}
