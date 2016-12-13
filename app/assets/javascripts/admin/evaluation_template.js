$(document).on("turbolinks:load", function() {
  $('#all-standards').on('click', '.list-group-item', function(){
    $('#all-standards').find('.selected').removeClass('selected');
    $(this).addClass('selected');
  });

  $('#select-standards').click(function(){
    $('#all-standards').find('.selected').each(function(index, standard){
      $(standard).removeClass('selected');
      $('#all-selected-standards').append(standard);
    });
  });
});
