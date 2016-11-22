$(document).on('turbolinks:load', function() {
  if ($('#evaluations').length > 0) {
    var total_point = 0;

    $('.evaluation-detail-point, input[type=checkbox]').change(function() {
      $('.evaluation-detail-point').each(function() {
        checkbox = $(this).closest('tr').find('input[type=checkbox]')[0].checked;
        if($(this).val() !== undefined && $(this).val() !== '' && checkbox) {
          total_point += parseFloat($(this).val());
        }
      });
      document.getElementById('trainee_evaluation_total_point').value = total_point;
      total_point = 0;
    });
  }
});
