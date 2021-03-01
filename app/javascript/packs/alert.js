$(document).on('turbolinks:load', function() {
  $(".alert").fadeIn(1000);
  // 3秒後に変化させる
  setTimeout(function() {
    $(".alert").fadeOut(1000);
  },5000);

});