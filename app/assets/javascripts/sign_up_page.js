$(document).ready(function() {
  hideOrg();

  $("#role").on("change", function() {
    hideOrg();
  });

});

function hideOrg() {
  var dropDown = $('#role').find("option:selected").text();
  console.log(dropDown)
  if (dropDown == "Volunteer" ) {
    $("#org_selector").hide();
  } else {
    $("#org_selector").show();
  };
}
