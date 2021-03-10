$(document).on('turbolinks:load', function() {
  
  $("#tags").tagit({
    tagLimit:10,
    singleField: true,
  });

  let tag_count = 10 - $(".tagit-choice").length
  $(".ui-widget-content.ui-autocomplete-input").attr('placeholder','あと' + tag_count + '個登録できます');

  $(document).on("keyup", '.tagit', function() {
    let tag_count = 10 - $(".tagit-choice").length
    $(".ui-widget-content.ui-autocomplete-input").attr(
    'placeholder','あと' + tag_count + '個登録できます');
  });


  
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


  $(".header-search").on('click', function(){
    $('#tag-bar').slideToggle();
    return false;
  });

  // // タグオープン
  // $(".header-search").on("click", function(){
  //   console.log("tag-open")
  //   $("#tag-bar").slideDown();
  //   return false;
  // });

  // // タグクローズ
  // $(".tag-close").on("click", function(){
  //   console.log("tag-close")
  //   $("#tag-bar").slideUp();
  //   return false;
  // });

  // タグバーを表示時に他のリンクをクリックした時、タグバーを非表示にする
  $("a").on("click", function() {
    $("#tag-bar").hide()
  });
});
