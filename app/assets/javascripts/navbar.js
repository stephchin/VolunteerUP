$(document).ready(function(){
  initialWindowSize = $( window ).width();
  if (initialWindowSize <= 816) {
    $("a#admin-console-nav").text("Admin");
    $("a#org-dashboard-nav").text("Orgs");
  } else {
    $("a#admin-console-nav").text("Admin Console");
    $("a#org-dashboard-nav").text("Org Dashboard");
  }


  $(window).resize(function() {
    resizedWindowSize = $( window ).width();
    // console.log(resizedWindowSize);
    if (resizedWindowSize <= 816) {
      $("a#admin-console-nav").text("Admin");
      $("a#org-dashboard-nav").text("Orgs");
    } else {
      $("a#admin-console-nav").text("Admin Console");
      $("a#org-dashboard-nav").text("Org Dashboard");
    }
  });


});
