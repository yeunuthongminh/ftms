$(document).on('turbolinks:load ajaxComplete', function() {
  $('.form-like').on('submit', function() {
    $('button.button-like', this).prop('disabled', true);
  });
});
