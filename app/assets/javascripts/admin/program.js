$(document).on('turbolinks:load', function() {
  var tbl_program = $('#tbl-program');
  if(tbl_program.length > 0) {
    set_datatable(tbl_program, [0, 2, 3, 4, 5]);
  }
});
