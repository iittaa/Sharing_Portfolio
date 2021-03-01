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
    $(".side-bg").animate({
      opacity: "0"
    }, 300);
    $(".open-side").removeClass("inactive");
  });

  // 項目選択時にもサイドバーをクローズする
  $("#ham-menu a").on("click", function(){
    $(this).animate({
      left: "-300px"
    });
    $(".side-bg").animate({
      opacity: "0"
    }, 300);
    console.log("clag")
  });


});
