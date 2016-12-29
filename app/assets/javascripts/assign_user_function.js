$(document).on('turbolinks:load', function() {
  $('#change-function').click(function() {
    var check = this;
    $("input[type='checkbox']").each(function() {
      check.prop('checked')
    });
  });
});
