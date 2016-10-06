$(document).on("turbolinks:load",function() {
  var click = false;

  $("div[class*=list_]").mouseenter(function(){
    $row = $(this).attr("class");
    var deltaTime = Date.now() - lastScrollingTime;
    if (deltaTime < 500) return false;
    if ($('div[class="'+ $row +'"]').hasClass("highlight-click")) {
      click = true;
      $('div[class="'+ $row +'"]').removeClass("highlight-click")
        .addClass("highlight");
    } else {
      $('div[class="'+ $row +'"]').addClass("highlight");
    }
  });

  $("div[class*=list_]").mouseleave(function(){
    $row = $(this).attr("class");
    if (click) {
      $('div[class="'+ $row +'"]').removeClass("highlight")
        .addClass("highlight-click");
      click = false;
    } else {
      $('div[class="'+ $row +'"]').removeClass("highlight");
    }
  });

  $("div[class*=list_]").click(function(e) {
    if(e.ctrlKey){
      $row = $(this).attr("class");
      if ($(this).hasClass("highlight-click") || click) {
        click = false;
      } else {
        $('div[class="'+ $row +'"]').addClass("highlight-click");
      }
    } else {
      $("div").removeClass("highlight-click");
      $row = $(this).attr("class");
      $('div[class="'+ $row +'"]').addClass("highlight-click");
    }
  });
});
