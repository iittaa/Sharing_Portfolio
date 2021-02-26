$(document).on('turbolinks:load', function() {
  $(".login-push").on("click", function() {
    console.log("click on!");
    $("#login-modal").fadeIn();
    return false;
  });

  $(".close-modal").on("click", function() {
    console.log("clcik off")
    $("#login-modal").fadeOut();
  });

  $(".close-modal-link").on("click", function() {
    console.log("clcik off2");
    $("#login-modal").hide();
  });



});