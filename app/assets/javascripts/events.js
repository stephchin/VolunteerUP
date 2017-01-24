$(document).ready(function(){
  createTweet();

  function createTweet() {
    console.log("updateTweet running");
    var event = $("#event-name").text();
    var org = $("#organization").text();
    $("#tweet").attr('data-text', "Excited for "+ org + "'s " + event + "! Join us " + "#volunteerup");
  }

});
