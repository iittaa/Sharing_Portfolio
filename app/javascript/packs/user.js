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

});