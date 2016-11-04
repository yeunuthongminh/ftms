$(document).on('turbolinks:load', function () {
  $('#required-sd-checkbox').change(function() {
    $('#required-subject-detail').toggleClass('hidden');
  });

  if ($('#percent_of_questions').length > 0) {
    var per_ques = $('#percent_of_questions').val();
    var ques_array = JSON.parse(per_ques);
    var easy = $('#per-easy');
    var normal = $('#per-normal');
    var hard = $('#per-hard');
    set_question_percent(ques_array);

    if (per_ques.length > 0) {
      $('#required-sd-checkbox').prop('checked', true);
      $('#required-subject-detail').removeClass('hidden');
    }

    $('#slider-percent-question').slider({
      range: true,
      min: 0,
      max: 100,
      values: [ques_array[0], ques_array[0] + ques_array[1]],
      slide: function (event, ui) {
        easy.val(ui.values[0]);
        normal.val(ui.values[1] - ui.values[0]);
        hard.val(100 - ui.values[1]);
        max_exam_point(easy, normal, hard);
      }
    });

    easy.bind('input', function () {
      $(this).attr('max', 100 - hard.val());
      var max_normal = 100 - $(this).val() - hard.val();
      normal.val(max_normal);
      $('#slider-percent-question').slider('values', [$(this).val(), 100 - hard.val()]);
      max_exam_point(easy, normal, hard);
    });

    normal.bind('input', function () {
      $(this).attr('max', 100 - easy.val());
      var max_hard = 100 - $(this).val() - easy.val();
      hard.val(max_hard);
      var normal_var = parseInt(easy.val()) + parseInt($(this).val());
      $('#slider-percent-question').slider('values', [easy.val(), normal_var]);
      max_exam_point(easy, normal, hard);
    });

    hard.bind('input', function () {
      $(this).attr('max', 100 - easy.val());
      var max_normal = 100 - $(this).val() - easy.val();
      normal.val(max_normal);
      $('#slider-percent-question').slider('values', [easy.val(), 100 - $(this).val()]);
      max_exam_point(easy, normal, hard);
    });

    $('#subject_subject_detail_attributes_number_of_question').bind('input', function() {
      max_exam_point(easy, normal, hard);
    });
  }

  $('#edit-subject-submit').click(function () {
    var easy_percent = easy.val();
    var normal_percent = normal.val();
    var hard_percent = hard.val()
    arr = '[' + easy_percent + ', ' + normal_percent + ', ' + hard_percent + ']';
    if ($('#required-sd-checkbox').prop('checked')) {
      $('#percent_of_questions').val(arr);
    } else {
      reset_subject_detail();
    }
  });
});

function set_question_percent(value) {
  percent_array = value;
  $('#per-easy').val(percent_array[0]);
  $('#per-normal').val(percent_array[1]);
  $('#per-hard').val(percent_array[2]);
}

function reset_subject_detail() {
  $('#subject_subject_detail_attributes_time_of_exam').val('');
  $('#subject_subject_detail_attributes_number_of_question').val('');
  $('#subject_subject_detail_attributes_min_score_to_pass').val('');
  $('#percent_of_questions').val('');
}

function max_exam_point(easy, normal, hard) {
  var number_question = parseInt($('#subject_subject_detail_attributes_number_of_question').val());
  if (number_question) {
    var easy_questions = parseInt(number_question*easy.val()/100);
    var normal_questions = 2*parseInt(number_question*normal.val()/100);
    var hard_questions = 3*parseInt(number_question*hard.val()/100);
    var min_score = easy_questions + normal_questions + hard_questions;
    $('#subject_subject_detail_attributes_min_score_to_pass').attr('max', parseInt(min_score));
  }
}
