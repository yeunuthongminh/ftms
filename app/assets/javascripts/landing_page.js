$(document).on('turbolinks:load', function(){
  $('.flexslider').flexslider({
    animation: 'slide'
  });

  $(document).on('click', '.scroll_to_section', function(e){
    e.preventDefault();
    var target = $(this).data('target');
    if($(target).length > 0) {
      $('html, body').animate({
        scrollTop: $(target).offset().top - $('#user-header .navbar').height()
      }, 500);
    } else {
      window.location = $(this).attr('href');
    }
  });

  $('.program-timeline').each(function(){
    var total_col = parseInt($(this).data('total-col'));
    var left = 0;
    $(this).find('.timeline-block').each(function(){
      var col = parseInt($(this).data('col'));
      var width = Math.floor(col * 10000 / total_col) / 100;
      $(this).width(width + '%');
      $(this).css('left', left + '%');
      left += width;
    });
  });

  $('.timeline-body .tooltip').on('hover', function(e){
    $(this).tooltip('bottom');
  });

  $(window).scroll(function(){
    $('figure.counter').each(function(index, counter){
      if($(counter).offset().top < $(window).height() + $(window).scrollTop()){
        if(parseInt($(counter).data('remaining')) > 0){
          var number = parseInt($(counter).text());
          $(counter).prop('Counter', 0).animate({
            Counter: number
          },{
            duration: 1500,
            easing: 'swing',
            step: function(now){
              if(parseInt($(counter).data('remaining')) > 0){
                var count = Math.ceil(now);
                $(counter).text(count);
                $(counter).data('remaining', number - count);
              }
            }
          });
        }
      }
    });

    $('.scroll').each(function(index, section) {
      if($(section).offset().top < $(window).height() + $(window).scrollTop()){
        $('a.scroll_to_section').removeClass('active');
        $('a[data-target="#' + $(section).attr('id') + '"]').addClass('active');
      }
    });
  });

  $('.timeline-heading img').mouseenter(function(){
    $(this).parent().parent().parent().find(".timeline-body")
      .toggle('slide');
  });

  $('.timeline-heading img').mouseout(function(){
    $(this).parent().parent().parent().find(".timeline-body")
      .toggle('slide');
  });
});
