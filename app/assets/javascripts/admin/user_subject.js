$(document).on('turbolinks:load', function() {
  if ($('#user-subject').length > 0) {
    $('.btn-show').on('click', function() {
      var data = $(this).data('id');
      $(this).closest('tbody').find('.user-subject-' + data)
        .toggleClass('show-task');
    });
  }
});
