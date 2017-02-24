$(document).ready(function() {
   $("#calendar").fullCalendar({
     events: "/users/" + $("#user_id").val() + "/get_events",
     timeFormat: "LT",
     defaultView: 'month',
     header: {
        left: 'title',
        center: '',
        right: 'prev,next month,agendaWeek,agendaDay',
      },
      height: 295,
     eventClick: function(event) {
      if (event.url) {
          window.open(event.url, "_blank");
          return false;
      }
    }
  });
});
