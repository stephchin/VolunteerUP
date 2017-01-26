$(document).ready(function() {
   $("#calendar").fullCalendar({
     events: "/users/" + $("#hid").val() + "/get_events",
     timeFormat: "LT",
     defaultView: 'month',
     header: {
      right: 'prev,next today',
      center: 'title',
      left: 'month,agendaWeek,agendaDay'
    },
     eventClick: function(calEvent) {
      if (calEvent.url) {
          window.open(calEvent.url);
          return false;
      }
    }
  });
});
