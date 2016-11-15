$(document).on("turbolinks:load", function() {
  var tbl_evaluation_standard = $("#evaluation-standard-tbl");
  if(tbl_evaluation_standard.length > 0) {
    set_datatable(tbl_evaluation_standard, [0, 2, 3, 4, 5]);
  }

  $('#evaluation_standard_min_point').unbind('focus').on('focus', function () {
    $(this).attr('max', $('#evaluation_standard_max_point').val());
  });
});
