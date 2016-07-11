  // function displayOnMap(position){
  //   debugger;
  //   var currentLocationInfowindow=new google.maps.InfoWindow({
  //     content: '<button onclick=addCurrentLocation()>Add Parking Area</button>'
  //   });
  //
  //   var marker = handler.addMarker({
  //     lat: position.coords.latitude,
  //     lng: position.coords.longitude
  //   });
  //   gon.current_location.push(marker)
  //
  //   google.maps.event.addListener(marker.getServiceObject(), 'click', function(object){
  //     currentLocationInfowindow.open(map, marker.getServiceObject());
  //   });
  //
  //   return marker;
  // };
  //
  // function addPressedLocation(){
  //   $.ajax({
  //       type : "POST",
  //       url : "/free_parking_areas/redirect_to_new_from_map.js",
  //       dataType: 'script',
  //       data : { lat: gon.new_parking_area[0].position.lat(), lng: gon.new_parking_area[0].position.lng() }
  //   });
  //   return false;
  // };
  //
  //
  // function addCurrentLocation(){
  //   $.ajax({
  //       type : "POST",
  //       url : "/free_parking_areas/redirect_to_new_from_map.js",
  //       dataType: 'script',
  //       data : { lat: gon.current_location[0].getServiceObject().position.lat(), lng: gon.current_location[0].getServiceObject().position.lng() }
  //   });
  //   return false;
  // };
  //
  //
  // function calcRoute(destinationLat, destinationLng) {
  //   var directionsService = new google.maps.DirectionsService();
  //   var directionsDisplay = new google.maps.DirectionsRenderer({suppressMarkers:true});
  //
  //   directionsDisplay.setMap(map)
  //   if(gon.current_location.length > 0) {
  //     var destination = new google.maps.LatLng(destinationLat, destinationLng);
  //
  //     var request = {
  //       origin: gon.current_location[0].getServiceObject().position,
  //       destination: destination,
  //       travelMode:  google.maps.DirectionsTravelMode.DRIVING
  //     };
  //     directionsService.route(request, function(response, status) {
  //       if (status == google.maps.DirectionsStatus.OK) {
  //         directionsDisplay.setDirections(response);
  //       };
  //     });
  //   } else {
  //     alert("You must have location enabled for directions")
  //   };
  // };
