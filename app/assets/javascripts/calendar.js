$(document).ready(function() {
   $("#calendar").fullCalendar({
     events: "/users/" + $("#hid").val() + "/get_events"
    //  eventClick: function(event) {
    //    if (event.url) {
    //      window.open(event.url);
    //      return false;
    //    }
    //  }
  });
});
