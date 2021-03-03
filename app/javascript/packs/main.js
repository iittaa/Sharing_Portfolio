$(document).on('turbolinks:load', function() {
  
  
  $(".total").fadeIn(1000);
  $("ham-menu a").on("click", function() {
    console.log("header click");
    $(".total").hide();
  });
  $("header a").on("click", function() {
    console.log("header click");
    $(".total").hide();
  });


  // モーダル表示
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

  
  // サイドバーオープン
  $(".open-side").on("click", function(){
    console.log("open!")
    $("#ham-menu").animate({
      left: "0"
    });
    $(".side-bg").css(
      "display", "block"
    ).animate({
      opacity: "0.5"
    }, 300);
    $(this).addClass("inactive");
  });

  // サイドバークローズ
  $(".close-side").on("click", function(){
    console.log("close!")
    $("#ham-menu").animate({
      left: "-300px"
    });
    $(".open-side").removeClass("inactive");
    $(".side-bg").fadeOut(300);
  });

  $("#ham-menu a").on("click", function(){
    $("#ham-menu").hide();
    $(".side-bg").hide();
    console.log("link click!");
  });
});
