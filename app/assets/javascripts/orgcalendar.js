$(document).ready(function() {
   $("#orgcalendar").fullCalendar({
     events: "/organizations/" + $("#organization_id").val() + "/get_orgevents",
     timeFormat: "LT",
     defaultView: 'month',
     header: {
        left: 'title',
        center: '',
        right: 'prev,next month,agendaWeek',
      },
      height: 350,
     eventClick: function(event) {
      if (event.url) {
          window.open(event.url, "_blank");
          return false;
      }
    }
  });
});
