$(document).on("turbolinks:load", function() {
  var tbl_category = $("#tbl-category");
  if(tbl_category.length > 0) {
    set_datatable(tbl_category, [0, 3, 4]);
  }
});
