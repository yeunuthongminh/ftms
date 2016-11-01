$(document).on("turbolinks:load", function() {
  $('#total_trainees .dropdown-menu').click(function(event){
    event.stopPropagation();
  });
  $('#color-picker').spectrum({
    preferredFormat: "name",
    showPalette: true,
    palette: ['#FFFF00', '#D02090', '#00FF7F',
      '#6A5ACD', '#FF0000', '#000080', '#808080',
      '#FFD700', '#FF8C00', '#00FFFF'],
    showSelectionPalette: true,
  });
  var tbl_user = $("#tbl-user");
  if(tbl_user.length > 0) {
    set_datatable(tbl_user, [0, 3, 4, 5]);
  }
  if ($('#check_role_trainee, #user_role_id').is(':checked')) {
    $('.profile-form').show();
  }
  $('#check_role_trainee').unbind('change').on('change', function() {
    if ($('#check_role_trainee').prop("checked")) {
      $('.profile-form').show();
    } else {
      $('.profile-form').hide();
    }
  });

  $('#user_trainer_id').unbind('change').on('change', function() {
    var location_select = $('#user_profile_attributes_location_id');
    var location_id = $('#user_trainer_id').find(':selected').data('location-id');
    if (location_id) {
      location_select.val(location_id);
    } else {
      location_select.val('');
    }
  });
   $('.btn-submit').click(function() {
    var graduation = $('input.graduation');
    var graduation_date = graduation.val();
    if (graduation_date) {
      graduation.val(graduation_date + '/01');
    }
    $('.edit_user').submit();
   });
});

var datepicker_options = {
  autoclose: true,
  enableOnReadonly: true,
  format: I18n.t("datepicker.time.short"),
  viewMode: "months",
  minViewMode: "months"
};

$(document).on('turbolinks:load ajaxComplete', function() {
  $('input.graduation').click(function() {
    $(this).datepicker(datepicker_options).datepicker('show');
  });
});
