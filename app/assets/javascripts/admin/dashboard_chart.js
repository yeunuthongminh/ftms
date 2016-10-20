$(document).on('turbolinks:load', function() {
  if ($('#finished_courses-chart').data('chart') != undefined &&
    $('#finished_courses-chart').data('chart').length > 0) {
    var data_finish_course_chart = $('#finished_courses-chart').data('chart');
    $('#finished_courses-chart').highcharts({
      chart: {
        type: 'column'
      },
      title: {
        text: I18n.t('charts.course_finished.title')
      },
      xAxis: {
        type: 'category'
      },
      yAxis: {
        allowDecimals: false,
        min: 0,
        title: {
          text: I18n.t('charts.course_finished.number_course')
        }
      },
      legend: {
        enabled: false
      },
      credits: {
        enabled: false
      },
      tooltip: {
        pointFormat: I18n.t('charts.course_finished.number_course_show')
      },
      series: [{
        data: data_finish_course_chart,
        color: 'green',
        dataLabels: {
          enabled: true,
          color: 'green',
          align: 'center',
          format: '{point.y:.1f}',
          y: 5,
          style: {
            fontSize: '12px',
            fontFamily: 'Verdana, sans-serif'
          }
        }
      }]
    });
  };
  if ($('#new_courses-chart').data('chart') != undefined &&
    $('#new_courses-chart').data('chart').length > 0) {
    var data_new_course_chart = $('#new_courses-chart').data('chart');
    $('#new_courses-chart').highcharts({
      chart: {
        type: 'column'
      },
      title: {
        text: I18n.t('charts.new_course.title')
      },
      xAxis: {
        type: 'category'
      },
      yAxis: {
        allowDecimals: false,
        min: 0,
        title: {
          text: I18n.t('charts.new_course.number_course')
        }
      },
      legend: {
        enabled: false
      },
      credits: {
        enabled: false
      },
      tooltip: {
        pointFormat: I18n.t('charts.new_course.number_course_show')
      },
      series: [{
        data: data_new_course_chart,
        dataLabels: {
          enabled: true,
          align: 'center',
          format: '{point.y:.1f}',
          y: 5,
          style: {
            fontSize: '12px',
            fontFamily: 'Verdana, sans-serif'
          }
        }
      }]
    });
  };
  if ($('#new_users-chart').data('chart') != undefined &&
    $('#new_users-chart').data('chart').length > 0) {
    var data_user_sign_up_chart = $('#new_users-chart').data('chart');
    $('#new_users-chart').highcharts({
      chart: {
        type: 'column'
      },
      title: {
        text: I18n.t('charts.user_sign_up.title')
      },
      xAxis: {
        type: 'category'
      },
      yAxis: {
        allowDecimals: false,
        min: 0,
        title: {
          text: I18n.t('charts.user_sign_up.number_user')
        }
      },
      legend: {
        enabled: false
      },
      credits: {
        enabled: false
      },
      tooltip: {
        pointFormat: I18n.t('charts.user_sign_up.number_user_show')
      },
      series: [{
        data: data_user_sign_up_chart,
        color: '#cecece',
        dataLabels: {
          enabled: true,
          color: '#fff',
          align: 'center',
          format: '{point.y:.1f}',
          y: 5,
          style: {
            fontSize: '12px',
            fontFamily: 'Verdana, sans-serif'
          }
        }
      }]
    });
  };
});
