
// $(document).ready(function(){
//   createTweet();
//
//   function createTweet() {
//     console.log("updateTweet running");
//     var event = $("#event-name").text();
//     var org = $("#organization").text();
//     $("#tweet").attr('data-text', "Excited for "+ org + "'s " + event + "! Join us " + "#volunteerup");
//   }
//
// });

function placeMakersUser(dataFromServer, markers) {
  console.log("user placeMarkers running");
  markers = handler.addMarkers(dataFromServer);
  handler.bounds.extendWith(markers);
  handler.fitMapToBounds();
}

function showLocations(dataFromServer) {
  console.log("user showLocations running");
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
        dataFromServer[dataFromServer.length] = {
        lat: position.coords.latitude,
        lng: position.coords.longitude,
        "picture": {
          "url": "http://pngimages.net/sites/default/files/user-png-image-30725.png",
          "width":  32,
          "height": 32
        },
        infowindow: "You!"
      };
      placeMakersUser(dataFromServer, markers);
    });
  } else {
    alert("Geolocation is not available");
    placeMakersUser(dataFromServer, markers)
  }
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
    var myurl = "/users/user_map_locations";
    // if ($("#search").val()) {
    //     myurl += "?search=" + $("#search").val();
    // };


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
