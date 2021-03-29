$(document).on('turbolinks:load', function() {
  
  // タグ機能のUI
  $("#tags").tagit({
    tagLimit:10, // タグの個数制限
    singleField: true // タグの一意性を確認
  });

  $(".tagit-close").addClass("expect");

  let tag_count = 10 - $(".tagit-choice").length
  $(".ui-widget-content.ui-autocomplete-input").attr('placeholder','あと' + tag_count + '個登録できます');

  $(document).on("keyup", '.tagit', function() {
    let tag_count = 10 - $(".tagit-choice").length
    $(".ui-widget-content.ui-autocomplete-input").attr(
    'placeholder','あと' + tag_count + '個登録できます');
  });


  // ドキュメント全体にfadeを適用
  $(".total").fadeIn(1000);
  
  // ドキュメント全体のfadeの修正(例外を除く)
  $("a").not(".expect").on("click", function() {
    console.log("link click");
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


  // サイドバー表示時に他のリンクをクリックしたら、サイドバーを非表示にする
  $("header a").on("click", function(){
    $("#ham-menu").hide();
    $(".side-bg").hide();
    console.log("link click!");
  });


  // タグバーを開閉する
  $(".header-search").on('click', function(){
    console.log("tagbar open")
    $('#tag-bar').slideToggle();
    return false;
  });


  // タグバーを表示時に他のリンクをクリックした時、タグバーを非表示にする
  $("a").on("click", function() {
    $("#tag-bar").hide()
  });

  // ユーザーページのタブバーの切り替え
  $(".user-nav-item").on("click", function(){
    $(".user-nav-item").removeClass("active");
    $(this).addClass("active");

    let index = $(".user-nav-item").index(this);
    $(".user-nav-content").eq(index).addClass("content-active");
    $(".user-nav-content").eq(index).siblings().removeClass("content-active");
  });


// 画像プレビュー機能
  function readURL(input) {
    if (input.files && input.files[0]) {
      let reader = new FileReader();
      reader.onload = function (e) {
        $('.img-prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

// フォームにてユーザー操作によって値が変更された時イベント発火
  $('.img-field').on("change", function(){
    readURL(this);
  });


});
