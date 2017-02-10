
$(document).ready(function(){
  console.log("document ready!");
  $("#map-tab").on("click", function(){
    console.log("map tab clicked");
    // timeout needs to be set so that page has time to load tab before calling gmap function
    setTimeout(loadAndCreateGmapUser, 1000);
  });

});

function placeMakersUser(dataFromServer, markers) {
  console.log("user placeMarkers running");
  markers = handler.addMarkers(dataFromServer);
  handler.bounds.extendWith(markers);
  handler.fitMapToBounds();
}

function showLocations(dataFromServer) {
  console.log("user showLocations running");
  placeMakersUser(dataFromServer);

  // Code to show User location commented out while team decides whether this
  // is the optimal solution- after decision is made code can
  // be uncommented or deleted

  // if (navigator.geolocation) {
  //   navigator.geolocation.getCurrentPosition(function(position) {
  //       dataFromServer[dataFromServer.length] = {
  //       lat: position.coords.latitude,
  //       lng: position.coords.longitude,
  //       "picture": {
  //         "url": "http://pngimages.net/sites/default/files/user-png-image-30725.png",
  //         "width":  32,
  //         "height": 32
  //       },
  //       infowindow: "You!"
  //     };
  //     placeMakersUser(dataFromServer, markers);
  //   });
  // } else {
  //   alert("Geolocation is not available");
  //   placeMakersUser(dataFromServer, markers)
  // }
}

function createGmapUser(dataFromServer) {
  console.log("createGmapUser running");
  console.log(dataFromServer);
  handler = Gmaps.build('Google');
  handler.buildMap({
    provider: {},
    internal: {id: 'user_map'}
  },
  function() {
    showLocations(dataFromServer);
    markers = handler.addMarkers(dataFromServer);
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
  }
);
};

function loadAndCreateGmapUser() {
  console.log("loadAndCreateGmapUser running");
  if ($("#user_map").length > 0) {
    var myurl = "/users/" + $("#user_id").val() + "/user_map_locations";
    console.log(myurl);

    $.ajax({
      dataType: 'json',
      url: myurl,
      method: 'GET',
      success: function(dataFromServer) {
        createGmapUser(dataFromServer)
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert("Getting map data failed: " + errorThrown);
      }
    });
  }
};

$(document).on('ready', loadAndCreateGmapUser);
$(document).on('turbolinks:load', loadAndCreateGmapUser);
