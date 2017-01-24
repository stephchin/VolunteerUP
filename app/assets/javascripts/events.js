// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

function placeMakers(dataFromServer, markers) {
  markers = handler.addMarkers(dataFromServer);
  handler.bounds.extendWith(markers);
  handler.fitMapToBounds();
}

function showLocations(dataFromServer) {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
        dataFromServer[dataFromServer.length] = {
        lat: position.coords.latitude,
        lng: position.coords.longitude,
        infowindow: "You!"
      };
      placeMakers(dataFromServer, markers);
    });
  } else {
    alert("Geolocation is not available");
    placeMakers(dataFromServer, markers)
  }
}

function createGmap(dataFromServer) {
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

function createGmaps(dataFromServer) {
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
};

function loadAndCreateGmaps() {
  if ($("#events_map").length > 0) {
    var myurl = "/events/map_locations";
    if ($("#search").val()) {
        myurl += "?search=" + $("#search").val();
    };


    $.ajax({
      dataType: 'json',
      url: myurl,
      method: 'GET',
      success: function(dataFromServer) {
        createGmaps(dataFromServer)
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert("Getting map data failed: " + errorThrown);
      }
    });
  }
};

$(document).on('ready', loadAndCreateGmap);
$(document).on('turbolinks:load', loadAndCreateGmap);
$(document).on('ready', loadAndCreateGmaps);
$(document).on('turbolinks:load', loadAndCreateGmaps);
