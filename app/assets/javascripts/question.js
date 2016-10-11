$(document).on('turbolinks:load', function() {
  var tbl_question = $('#tbl-question');
  if(tbl_question.length > 0) {
    set_datatable(tbl_question, [0, 4, 5]);
  }
});
