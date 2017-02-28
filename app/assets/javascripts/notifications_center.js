$(document).ready(function()
{
    // open notification center on click
    $("#open_notification").click(function()
    {
        $("#notificationContainer").fadeToggle(300);
        $("#notification_count").fadeOut("fast");
        return false;
    });

    // hide notification center on click
    $(document).click(function()
    {
        $("#notificationContainer").hide();
    });


    // $("#notificationContainer").click(function()
    // {
    //     return false;
    // });
    // alert);

    $("#notificationList").on("click", ".delete-notification", function(){

      $(this).parent('li').remove();

      var num = $("#notification-counter").text();
      $("#notification-counter").text(num - 1);

      if (num - 1 === 0){
        $("#notification-counter").css("background-color", "grey");
      };


    });



});
