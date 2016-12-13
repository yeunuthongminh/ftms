function totalTraineeValue() {
  if ($('#statistics').length > 0) {
    if ($('#total_trainees').length > 0) {
      $('.fixedTable-header .trainee-by-month').each(function(key, value) {
        var total_trainee_in_month = 0
        var total_trainee_in_month_filter = 0;

        $.each($('.fixedTable-body .total-trainees-month-' + $(value)
          .data('month')), function(index, element) {
          if(!$(element).hasClass('total')){
            total_trainee_in_month += parseInt($(element).data('total-trainees'));
          }
        });

        $.each($('.fixedTable-body .trow:visible .total-trainees-month-' + $(value).data('month')), function(index, element) {
          if(!$(element).hasClass('total')){
            total_trainee_in_month_filter += parseInt($(element).data('total-trainees'));
          }
        });

        percent = total_trainee_in_month_filter / total_trainee_in_month * 100;
        if (percent == 100 || total_trainee_in_month == 0) {
          $('#fixed-bottom-body .total-trainees-month-' + $(value).data('month')).text(total_trainee_in_month_filter.toLocaleString());
        } else {
          $('#fixed-bottom-body .total-trainees-month-' + $(value).data('month'))
            .text(total_trainee_in_month_filter.toLocaleString() + ' - ' +
            Math.round(percent).toFixed(2) + '%');
        }
      });
    };

    if($('#universities').length > 0) {
      counting_trainee("university");
    }

    if($('#languages').length > 0) {
      counting_trainee("language");
    }

    if($('#trainee_types').length > 0) {
      counting_trainee("trainee_type");
    }

    if($('#locations').length > 0) {
      counting_trainee("location");
    }

    if($('#stages').length > 0) {
      counting_trainee("stage");
    }
  }
}

function counting_trainee(type){
  var trainees = total_trainee(type);
  var trainees_filter = total_trainee_filter(type);
  view_total_trainee(type, total_trainee, false);
  percent = trainees_filter / trainees * 100;
  if (percent == 100 || trainees == 0) {
    view_total_trainee(type, trainees_filter, false);
  } else {
    view_total_trainee(type, trainees_filter, true);
  }
}

function total_trainee(statistic_type){
  var total = 0;
  $('.fixedTable-body .trainee-by-'+statistic_type).each(function(key, value)  {
    total += parseInt($(value).data('total-trainees'));
  });
  return total;
}

function total_trainee_filter(statistic_type){
  var total = 0;
  $('.fixedTable-body .trow:visible .trainee-by-'+statistic_type)
    .each(function(index, element) {
    if(!$(element).hasClass('total')){
      total += parseInt($(element)
        .data('total-trainees'));
    }
  });
  return total;
}

function view_total_trainee(statistic_type, total_trainee, flag){
  if (flag) {
    $('#total-trainees-'+statistic_type)
      .text(total_trainee.toLocaleString() + ' - ' +
      Math.round(percent).toFixed(2) + '%');
  } else {
    $('#total-trainees-'+statistic_type)
      .text(total_trainee.toLocaleString());
  }
}
