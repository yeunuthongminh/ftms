$(document).on('turbolinks:load', function () {
  if ($('#percent_of_questions').length > 0) {
    var per_ques = $('#percent_of_questions').val();
    var ques_array = JSON.parse(per_ques);
    set_question_percent(ques_array);

    $("#slider-percent-question").slider({
      range: true,
      min: 0,
      max: 100,
      values: [ques_array[0], ques_array[0] + ques_array[1]],
      slide: function (event, ui) {
        $('#per-easy').val(ui.values[0]);
        $('#per-normal').val(ui.values[1] - ui.values[0]);
        $('#per-hard').val(100 - ui.values[1]);
      }
    });
  }

  $('#edit-subject-submit').click(function () {
    var easy = $('#per-easy').val();
    var normal = $('#per-normal').val();
    var hard = $('#per-hard').val()
    arr = '[' + easy + ', ' + normal + ', ' + hard + ']';
    $('#percent_of_questions').val(arr);
  });
});

function set_question_percent(value) {
  percent_array = value;
  $('#per-easy').val(percent_array[0]);
  $('#per-normal').val(percent_array[1]);
  $('#per-hard').val(percent_array[2]);
}
