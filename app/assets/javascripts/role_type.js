$(document).on("turbolinks:load", function() {
  var selected = document.getElementById("role_type");
  if (selected) {
    var value_seledted = selected.options[selected.selectedIndex].value;
    select_role_type(value_seledted);
  }

  $('#role_type').change(function () {
    var select = document.getElementById("role_type");
    var value_select = select.options[select.selectedIndex].value;
    select_role_type(value_select);
  });

  $(':checkbox.sltAll').click(function () {
    var klass = $(this).data("parent");
    $('.list_' + klass + ' input:visible[type="checkbox"]').prop('checked', this.checked);
  });


  $('.route_admin').find(':checkbox.sltAll').each(function () {
    var find_by_class = $(this).data("parent");
    var checkboxs = $('.route_admin').find('.list_' + find_by_class + ' :checkbox');
    $(this).prop('checked',
      checkboxs.not(':checked').length < 2);
  });

  $('.route_trainer').find(':checkbox.sltAll').each(function () {
    var find_by_class = $(this).data("parent");
    var checkboxs = $('.route_trainer').find('.list_' + find_by_class + ' :checkbox');
    $(this).prop('checked',
      checkboxs.not(':checked').length < 2);
  });

  $('.route_trainee').find(':checkbox.sltAll').each(function () {
    var find_by_class = $(this).data("parent");
    var checkboxs = $('.route_trainee').find('.list_' + find_by_class + ' :checkbox');
    $(this).prop('checked',
      checkboxs.not(':checked').length < 2);
  });

  $('#checked_all').click(function () {
    $('input:visible[type="checkbox"]').prop('checked', this.checked);
  });
  checked_all();
});

function select_role_type(value_seledted) {
  switch (value_seledted) {
    case "admin":
      $('.route_admin').show();
      $('.route_trainer').hide();
      $('.route_trainee').hide();
      stt();
      checked_all();
      break;
    case "trainer":
      $('.route_admin').hide();
      $('.route_trainer').show();
      $('.route_trainee').hide();
      stt();
      checked_all();
      break;
    case "trainee":
      $('.route_admin').hide();
      $('.route_trainer').hide();
      $('.route_trainee').show();
      stt();
      checked_all();
      break;
  }
}

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
