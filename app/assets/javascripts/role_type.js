$(document).on("turbolinks:load", function() {
  var selected = document.getElementById("role_type");
  if (selected) {
    var value_seledted = selected.options[selected.selectedIndex].value;
    select_role_type(value_seledted);
  }

  $(':checkbox.sltAll').click(function () {
    var klass = $(this).data("parent");
    $('.list_' + klass + ' input:visible[type="checkbox"]').prop('checked', this.checked);
  });

  $('#checked_all').click(function () {
    $('input:visible[type="checkbox"]').prop('checked', this.checked);
  });

  $('.trow.trow-items').each(function (){
    $('input:checkbox.sltAll', this).prop('checked',
      !$('input:checkbox:not(:checked):not(.sltAll)', this).length);
  });

  checked_all();
});

function stt() {
  var stt = 0;
  var list_trow = $('#list-records').find('.trow .stt:visible');
  $.each(list_trow, function () {
    stt++;
    $(this).html(stt);
  })
}

function checked_all() {
  $('#checked_all').prop('checked',
    $('input:visible[type="checkbox"]').not(':checked').length <= 1);
}
