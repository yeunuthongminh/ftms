$(document).on("turbolinks:load", function() {
  $('#total_trainees .dropdown-menu').click(function(event) {
    event.stopPropagation();
  });
  $('#color-picker').spectrum({
    preferredFormat: "name",
    showPalette: true,
    palette: ['#000000', '#434343', '#666666',
      '#999999', '#b7b7b7', '#cccccc', '#d9d9d9', '#efefef', '#f3f3f3',
      '#ffffff', '#980000', '#ff0000', '#ff9900', '#ffff00', '#00ff00',
      '#00ffff', '#4a86e8', '#0000ff', '#9900ff', '#ff00ff', '#e6b8af',
      '#f4cccc', '#fce5cd', '#fff2cc', '#d9ead3', '#d0e0e3', '#c9daf8',
      '#cfe2f3', '#d9d2e9', '#ead1dc', '#dd7e6b', '#ea9999', '#f9cb9c',
      '#ffe599', '#b6d7a8', '#a2c4c9', '#a4c2f4', '#9fc5e8', '#b4a7d6',
      '#d5a6bd', '#cc4125', '#e06666', '#f6b26b', '#ffd966', '#93c47d',
      '#76a5af', '#6d9eeb', '#6fa8dc', '#8e7cc3', '#c27ba0', '#a61c00',
      '#cc0000', '#e69138', '#f1c232', '#6aa84f', '#45818e', '#3c78d8',
      '#3d85c6', '#674ea7', '#a64d79', '#85200c', '#990000', '#b45f06',
      '#bf9000', '#38761d', '#134f5c', '#1155cc', '#0b5394', '#351c75',
      '#741b47', '#5b0f00', '#660000', '#783f04', '#7f6000', '#274e13',
      '#0c343d', '#1c4587', '#073763', '#20124d', '#4c1130'],
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

  $(function() {
    var $formLogin = $('#login-form');
    var $formLost = $('#lost-form');
    var $formRegister = $('#register-form');
    var $divForms = $('#div-forms');
    var $modalAnimateTime = 400;
    var $msgAnimateTime = 150;
    var $msgShowTime = 3000;

    $('#login_register_btn').click(function () {
      modalAnimate($formLogin, $formRegister)
    });
    $('#register_login_btn').click(function () {
      modalAnimate($formRegister, $formLogin);
    });
    $('#login_lost_btn').click(function () {
      modalAnimate($formLogin, $formLost);
    });
    $('#lost_login_btn').click(function () {
      modalAnimate($formLost, $formLogin);
    });
    $('#register_lost_btn').click(function () {
      modalAnimate($formRegister, $formLost);
    });

    function modalAnimate($oldForm, $newForm) {
      var $oldH = $oldForm.height();
      var $newH = $newForm.height();
      $divForms.css("height", $oldH);
      $oldForm.fadeToggle($modalAnimateTime, function() {
        $divForms.animate({height: $newH}, $modalAnimateTime, function() {
          $newForm.fadeToggle($modalAnimateTime);
        });
      });
    }

    $('input[name="location_ids[]"]').click(function () {
      $('input[name="check_visit"]').attr('checked', true);
      $('#form_total_trainee').submit();
    });
  });
  $('#TaskModal').on('hidden.bs.modal', function () {
    $(this).find(".form-control").val('').end();
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
