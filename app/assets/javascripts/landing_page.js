$(document).on('turbolinks:load', function(){
  $('.flexslider').flexslider({
    animation: 'slide'
  });

  $('.scroll_to_section').click(function(e){
    e.preventDefault();
    var target = $(this).data('target');
    $('html, body').animate({
      scrollTop: $('#' + target).offset().top - $('#user-header').height()
    }, 1000);
  });
});
