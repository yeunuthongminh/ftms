function load_trainee_types_statistic_chart() {
  $('#trainee-types-statistic').highcharts({
    chart: {
      plotBackgroundColor: null,
      plotBorderWidth: null,
      plotShadow: false,
      type: 'pie'
    },
    title: false,
    tooltip: {
      formatter: function () {
        return I18n.t('universities.header.name') + ': ' + '<strong>' + this.key + '</strong>' + ' <br/>' +
          I18n.t('statistics.universities.serie_name') + ': ' + '<strong>' + this.y + '</strong>';
      }
    },
    plotOptions: {
      pie: {
        allowPointSelect: true,
        cursor: 'pointer',
        dataLabels: {
          enabled: true,
          format: '<b>{point.name}</b>: {point.extraValue}'
        },
        showInLegend: true
      }
    },
    series: [{
      name: I18n.t('statistics.trainee_types.serie_name'),
      colorByPoint: true,
      data: eval("(" + $('#trainee-types-statistic').attr("data-trainee-types").replace(/&gt;/g, ">").replace(/&quot;/g,"\"").replace(/:name=>/g, "name:").replace(/:y=>/g, "y:").replace(/:extraValue=>/g, "extraValue:") + ')')
    }]
  });
}

function load_universities_statistic_chart() {
  $('#universities-statistic').highcharts({
    chart: {
      plotBackgroundColor: null,
      plotBorderWidth: null,
      plotShadow: false,
      type: 'pie'
    },
    title: false,
    tooltip: {
      formatter: function () {
        return I18n.t('universities.header.name') + ': ' + '<strong>' + this.key + '</strong>' + ' <br/>' +
          I18n.t('statistics.universities.serie_name') + ': ' + '<strong>' + this.y + '</strong>';
      }
    },
    plotOptions: {
      pie: {
        allowPointSelect: true,
        cursor: 'pointer',
        dataLabels: {
          enabled: true,
          format: '<b>{point.name}</b>: {point.extraValue}'
        },
        showInLegend: true
      }
    },
    series: [{
      name: I18n.t('statistics.universities.serie_name'),
      colorByPoint: true,
      data: eval('(' + $('#universities-statistic').attr('data-universities').replace(/&gt;/g, ">").replace(/&quot;/g,"\"").replace(/:y=>/g, "y:").replace(/:name=>/g, "name:").replace(/:extraValue=>/g, "extraValue:") + ')')
    }]
  });
}

function load_languages_statistic_chart() {
  $('#languages-statistic').highcharts({
    chart: {
      plotBackgroundColor: null,
      plotBorderWidth: null,
      plotShadow: false,
      type: 'pie'
    },
    title: false,
    tooltip: {
      formatter: function () {
        return I18n.t('statistics.languages.name') + ': ' + '<strong>' + this.key + '</strong>' + ' <br/>' +
          I18n.t('statistics.languages.serie_name') + ': ' + '<strong>' + this.y + '</strong>';
      }
    },
    plotOptions: {
      pie: {
        allowPointSelect: true,
        cursor: 'pointer',
        dataLabels: {
          enabled: true,
          format: '<b>{point.name}</b>: {point.extraValue}'
        },
        showInLegend: true
      }
    },
    series: [{
      name: I18n.t('statistics.languages.serie_name'),
      colorByPoint: true,
      data: eval('(' + $('#languages-statistic').attr('data-languages').replace(/&gt;/g, ">").replace(/&quot;/g,"\"").replace(/:y=>/g, "y:").replace(/:name=>/g, "name:").replace(/:extraValue=>/g, "extraValue:") + ')')
    }]
  });
}

function load_locations_statistic_chart() {
  var locations_chart = new Highcharts.Chart({
    chart: {
      renderTo: 'locations-statistic'
    },
    title: false,
    xAxis: {
      categories: $('#locations-statistic').data('locations'),
      crosshair: true
    },
    yAxis: {
      min: 0,
      title: {
        text: I18n.t('statistics.locations.y_asis')
      }
    },
    tooltip: {
      headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
      pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
        '<td style="padding:0"><b> {point.y} '+ I18n.t('statistics.locations.surfix') +'</b></td></tr>',
      footerFormat: '</table>',
      shared: true,
      useHTML: true
    },
    plotOptions: {
      column: {
        pointPadding: 0.2,
        borderWidth: 0
      }
    },
    series: [{
      type: 'column',
      name: I18n.t('statistics.locations.serie_name'),
      data: $('#locations-statistic').data('trainees')

    }]
  });

  $.each($('[id^="location-select-"]'), function (index, value){
    $(value).click(function () {
      var data = [];
      var data_points = JSON.parse($('#locations-statistic').data('charts').replace(/:/g, "").replace(/=>/g, ":"));

      if ($(this).hasClass('checked')) {
        var categories = [];
        $(this).removeClass('checked');
        $(this).css('color', 'black');

        for (i = 0; i < data_points.length; i++) {
          if (!$('#location-select-' + i).hasClass('checked')) {
            categories.push($('#locations-statistic').data('locations')[i]);
            data.push([$('#locations-statistic').data('locations')[i], data_points[i].y]);
          }
        }
        locations_chart.xAxis[0].setCategories(categories);
      } else {
        var no = $('#locations-statistic').data('locations').indexOf($(this).find('.location-name').text());
        $(this).addClass('checked');
        $(this).css('color', 'gray');

        locations_chart.xAxis[0].setCategories($('#locations-statistic').data('locations'), false);

        for (i = 0; i < data_points.length; i++) {
          if (i !== no && !$('#location-select-' + i).hasClass('checked')) {
            data.push([data_points[i].x, data_points[i].y]);
          }
        }
      }
      locations_chart.series[0].setData(data);
    });
  });
}

function load_trainee_in_out_by_month_statistic_chart() {
  $('#in-out-by-month-statistic').highcharts({
    chart: {
      type: 'column'
    },
    title: false,
    xAxis: {
      categories: $('#in-out-by-month-statistic').data('months'),
      min: 0.5,
      tickmarkPlacement: 'on',
      startOnTick: false,
      endOnTick: false,
      minPadding: 0,
      maxPadding: 0,
      align: 'left'
    },
    yAxis: {
      title: {
        text: I18n.t('statistics.in_out_by_month.x_asis')
      },
      plotLines: [{
        value: 0,
        width: 1,
        color: '#808080'
      }]
    },
    tooltip: {
      valueSuffix: I18n.t('statistics.in_out_by_month.surfix')
    },
    legend: {
      layout: 'vertical',
      align: 'right',
      verticalAlign: 'middle',
      borderWidth: 0
    },
    plotOptions: {
      line: {
        dataLabels: {
          enabled: true
        }
      }
    },
    series: [{
      name: I18n.t('statistics.in_out_by_month.series.trainee_in'),
      data: $('#in-out-by-month-statistic').data('trainee-in')
    }, {
      name: I18n.t('statistics.in_out_by_month.series.trainee_out'),
      data: $('#in-out-by-month-statistic').data('trainee-out')
    }, {
      name: I18n.t('statistics.in_out_by_month.series.trainee_join_div'),
      data: $('#in-out-by-month-statistic').data('trainee-join-div')
    }, {
      name: I18n.t('statistics.in_out_by_month.series.trainee_away'),
      data: $('#in-out-by-month-statistic').data('trainee-away')
    },]
  });
}

$(document).on('turbolinks:load', function() {
  if ($('#statistics').children().hasClass('trainee_types')) {
    load_trainee_types_statistic_chart();
  } else if ($('#statistics').children().hasClass('universities')) {
    load_universities_statistic_chart();
  } else if ($('#statistics').children().hasClass('languages')) {
    load_languages_statistic_chart();
  } else if ($('#statistics').children().hasClass('locations')) {
    load_locations_statistic_chart();
  } else if ($('#statistics').children().hasClass('in_out_by_month')) {
    load_trainee_in_out_by_month_statistic_chart();
  }
});
