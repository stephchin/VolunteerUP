$(document).ready(function() {
   $("#orgcalendar").fullCalendar({
     events: "/organizations/" + $("#organization_id").val() + "/get_orgevents",
     timeFormat: "LT",
     defaultView: 'month',
     header: {
        left: 'prev,next',
        center: 'title',
        right: 'month,agendaWeek',
      },
      height: 395,
     eventClick: function(event) {
      if (event.url) {
          window.open(event.url, "_blank");
          return false;
      }
    }
  });
});
