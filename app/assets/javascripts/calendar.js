$(document).ready(function() {
   $("#calendar").fullCalendar({
     events: "/users/" + $("#user_id").val() + "/get_events",
     timeFormat: "LT",
     defaultView: 'month',
     header: {
        right: 'prev,next',
        center: 'title',
        left: 'month,agendaWeek,agendaDay'
      },
     eventClick: function(event) {
      if (event.url) {
          window.open(event.url, "_blank");
          return false;
      }
    }
  });
});
