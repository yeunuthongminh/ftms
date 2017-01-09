$(document).on("turbolinks:load", function() {
  var flex = null;

  $('.flex-disabled').click(function(e){
    e.preventDefault();
    return false;
  });

  $('#skip-kickoff').click(function(){
    var last = $('.slides li', $(this).prev())
      .index($('.slides li:last', $(this).prev()));
    flex.flexslider(last);
  });

  if($('#subject-show').data('show-kickoff')) {
    $('#kickoff_modal').modal();
  }

  $('#kickoff_modal').on('shown.bs.modal', function(){
    flex = $('#kickoff_modal .flexslider').flexslider({
      animation: 'slide',
      slideshow: false,
      controlNav: false,
      keyboardNav: false,
      animationLoop: false
    });
  });
});
