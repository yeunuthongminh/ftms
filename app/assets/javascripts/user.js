$(document).on("turbolinks:load", function() {
  $('#total_trainees .dropdown-menu').click(function(event) {
    event.stopPropagation();
  });

  var tbl_user = $("#tbl-user");
  if(tbl_user.length > 0) {
    set_datatable(tbl_user, [0, 3, 4, 5]);
  }

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
  });

  $('#TaskModal').on('hidden.bs.modal', function () {
    $(this).find(".form-control").val('').end();
  });

  $('input[name="location_ids[]"]').click(function(){
    $('input[name="check_visit"]').attr('checked', true);
    $('input[name="check_location"]').val(1);
    $('#form_total_trainee').submit();
    $('#form_universities_filter').submit();
    $('#form_languages_filter').submit();
    $('#form_stages_filter').submit();
  });

  $('input[name="trainee_type_ids[]"]').click(function(){
    $('input[name="check_trainee_type"]').val(1);
    $('#form_universities_filter').submit();
    $('#form_languages_filter').submit();
    $('#form_stages_filter').submit();
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
