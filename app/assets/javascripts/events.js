
$(document).ready(function(){
  createTweet();

  function createTweet() {
    console.log("updateTweet running");
    var event = $("#event-name").text();
    var org = $("#organization").text();
    $("#tweet").attr('data-text', "Excited for "+ org + "'s " + event + "! Join us " + "#volunteerup");
  }

});


function placeMakers(dataFromServer, markers) {
  console.log("placeMakers running");
  markers = handler.addMarkers(dataFromServer);
  handler.bounds.extendWith(markers);
  handler.fitMapToBounds();
}

function showLocations(dataFromServer) {
  console.log("showLocations running");
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
      placeMakers(dataFromServer, markers);
    });
  } else {
    alert("Geolocation is not available");
    placeMakers(dataFromServer, markers);
  }
}

function createGmap(dataFromServer) {
  console.log("createGmap running");
  handler = Gmaps.build('Google');
  handler.buildMap({
    provider: {},
    internal: {id: 'event_map'}
  },
  function() {
    showLocations(dataFromServer);
    markers = handler.addMarkers(dataFromServer);
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
  });
};

function createGmapAll(dataFromServer) {
  console.log("createGmapAll running");
  console.log(dataFromServer);
  handler = Gmaps.build('Google');
  handler.buildMap({
    provider: {},
    internal: {id: 'events_map'}
  },
  function() {
    showLocations(dataFromServer);
    markers = handler.addMarkers(dataFromServer);
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
  }
);
};


function loadAndCreateGmap() {
  console.log("loadAndCreateGmap running");
  if ($("#event_map").length > 0) {
    var eventId = $('#event_map').attr('data-event-id');
    $.ajax({
      dataType: 'json',
      url: '/events/' + eventId + '/map_location',
      method: 'GET',
      success: function(dataFromServer) {
        createGmap(dataFromServer);
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert("Getting map data failed: " + errorThrown);
      }
    });
  }
}

function loadAndCreateGmapAll() {
  if ($("#events_map").length > 0) {
    var myurl = "/events/map_locations?";
    // var zip = $("#filterrific_with_distance_zip").val();
    var zip = $("#events_map").attr("data-zip");
    // var max_dist = $("#filterrific_with_distance_max_distance option:selected").val();
    var max_dist = $("#events_map").attr("data-distance");
    // var search = $("#events_map").attr("data-search");
    var search = $("#filterrific_search_query").val();
    var sortedBy = $("#filterrific_sorted_by").val();
    var page = $("li.page-item.active a").text();
    myurl += "page=" + page;
    console.log("this", sortedBy);
    console.log("zip",zip);
    console.log("max_dist:",max_dist);
    console.log("search:",search);
    console.log("page:",page);

    if (search || (zip && max_dist) || sortedBy) {
      myurl += "&filterrific[with_distance][zip]=" + zip +
        "&filterrific[with_distance][max_distance]=" + max_dist +
        "&filterrific[search_query]=" + search +
        "&filterrific[sorted_by]=" + sortedBy;
    }
    console.log(myurl);

    $.ajax({
      dataType: 'json',
      url: myurl,
      method: 'GET',
      success: function(dataFromServer) {
        createGmapAll(dataFromServer);
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert("Getting map data failed: " + errorThrown);
      }
    });
  }
};

$(document).on('ready', loadAndCreateGmap);
$(document).on('turbolinks:load', loadAndCreateGmap);
$(document).on('ready', loadAndCreateGmapAll);
$(document).on('turbolinks:load', loadAndCreateGmapAll);
