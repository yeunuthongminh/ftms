$(document).on("turbolinks:load", function() {
  var tbl_university = $("#university-tbl");
  if(tbl_university.length > 0) {
    set_datatable(tbl_university, [0, 2, 3, 4]);
  }

  if ($('#university-form').length > 0) {
    $('#university_name').keydown(function(){
      $('#university_abbreviation').val(extract_uppercase($(this).val()));
    });
  }
});

function extract_uppercase(input_string) {
  var positions = [];
  for (var i = 0; i < input_string.length; i++) {
    if (input_string[i].match(/[A-Z]/) != null) {
      positions.push(input_string[i]);
    }
  }
  return positions.join('');
}
