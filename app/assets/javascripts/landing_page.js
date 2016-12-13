$(document).on('turbolinks:load', function(){
  $('.flexslider').flexslider({
    animation: 'slide'
  });

  $('.scroll_to_section').click(function(e){
    e.preventDefault();
    var target = $(this).data('target');
    if($(target).length > 0) {
      $('html, body').animate({
        scrollTop: $(target).offset().top - $('#user-header').height()
      }, 500);
    } else {
      window.location = $(this).attr('href');
    }
  });

  $('.program-timeline').each(function(index, program) {
    var total_col = parseInt($(program).data('total-col'));
    $(program).find('.timeline-block').each(function(index, block) {
      var col = parseInt($(block).data('col'));
      $(block).width(col * 100 / total_col + '%');
    });
  });

  $('.timeline-body .tooltip').on('hover', function(e){
    $(this).tooltip('bottom');
  });
});
