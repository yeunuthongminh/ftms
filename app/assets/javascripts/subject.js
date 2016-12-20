function load_chart() {
  $('#user-subjects-charts').highcharts({
    chart: {
      type: 'column'
    },
    title: {
      text: I18n.t('user_subjects.chart.title')
    },
    xAxis: {
      categories: $('#user-subjects-charts').data('user-name'),
      crosshair: true
    },
    yAxis: {
      min: 0,
      title: {
        text: I18n.t('user_subjects.chart.y_axis')
      }
    },
    tooltip: {
      headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
      pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
      '<td style="padding:0"><b>{point.y}</b></td></tr>',
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
      name: I18n.t('user_subjects.chart.task_total'),
      data: $('#user-subjects-charts').data('total-number-tasks')
    }]
  });
}

function setbutton() {
  $('.finish-subject').click(function(e) {
    e.preventDefault();
    var exec_finish = document.getElementById('finish-subject-exam');
    if (exec_finish) {
      $("#dialog-finish").dialog({
        modal: true,
        width: 550,
        buttons: [
          {
            text: I18n.t("user_subjects.finish.with_exam"),
            click: function() {
              exec_finish.href = exec_finish.href + '?exam=waiting';
              $(exec_finish).trigger('click');
            }
          },
          {
            text: I18n.t("user_subjects.finish.without_exam"),
            click: function() {
              $(exec_finish).trigger('click');
            }
          },
          {
            text: I18n.t("buttons.cancel"),
            click: function() {$(this).dialog('close');}
          }
        ]
      });
    } else {
      exec_finish = document.getElementById('finish-subject-project');
      $("#dialog-finish").dialog({
        modal: true,
        width: 300,
        buttons: [
          {
            text: I18n.t("user_subjects.finish.with_present"),
            click: function() {
              $(exec_finish).trigger('click');
            }
          },
          {
            text: I18n.t("buttons.cancel"),
            click: function() {$(this).dialog('close');}
          }
        ]
      });
    }
  });
}

function do_exam() {
  $('.do-exam-now').click(function(e) {
    e.preventDefault();
    var exec_finish = document.getElementById('finish-subject-exam');
    if (exec_finish) {
      $("#dialog-finish").dialog({
        modal: true,
        width: 350,
        buttons: [
          {
            text: I18n.t("user_subjects.finish.with_exam"),
            click: function() {
              exec_finish.href = exec_finish.href + '?exam=waiting';
              $(exec_finish).trigger('click');
            }
          },
          {
            text: I18n.t("buttons.cancel"),
            click: function() {$(this).dialog('close');}
          }
        ]
      });
    }
  });
}

$(document).on('turbolinks:load', function() {
  var tbl_subject = $('#subjects');

  ajax_update_status();

  if (tbl_subject.length > 0) {
    set_datatable(tbl_subject, [0, 2]);
  }

  load_chart();
  setbutton();
  do_exam();
});

$(document).on('ajaxComplete', function(){
  if ($('.user-lists').length) {
    setbutton();
  } else {
    load_chart();
  }
});

function set_class_select_status(select_status) {
  var color = $('option:selected', $(select_status)).attr('class');
  $(select_status).attr('class', color + " stt-user-subject");
}

function ajax_update_status() {
  var select_status = $('.stt-user-subject');

  select_status.each(function() {
    set_class_select_status(this);
  });

  select_status.change(function() {
    var status = $('option:selected', this).text().toLowerCase(),
        popup_body = I18n.t("notices.change_status.user_subject")
          + "<span class='label-dialog-status'>&nbsp;" + status + "&nbsp;</span>";

    var popup_object = {
      id: "confirm-dialog",
      large_modal: true,
      header_type: "dangerous",
      header_title: I18n.t("notices.attention"),
      body_content: popup_body,
      footer_btn: [
        {
          id: "submit-update-status",
          class: "btn-danger",
          title: I18n.t("buttons.update_status"),
          dismiss: false
        },
        {
          id: "cancel-update-status",
          class: "btn-secondary",
          title: I18n.t("buttons.cancel"),
          dismiss: true
        }
      ]
    };

    $('#user-subject').after(popup_html(popup_object));

    var text_color = $('option:selected', this).attr('class');
    $('.label-dialog-status').attr('class', text_color + " label-dialog-status")
    $('#confirm-dialog').modal('show');
    element = this;

    $('#cancel-update-status').click(element, function() {
      reset_select_status(element);
    });

    $('#submit-update-status').click(element, function() {
      $.ajax({
        method: 'PATCH',
        url: $(element).data('id'),
        data: {status: $(element).val()},
        complete: function() {
          $('#confirm-dialog').modal('hide');
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
          reset_select_status(element);
        }
      });
    });
  });

  function reset_select_status(element) {
    $('option', element).prop('selected', function() {
      return this.defaultSelected;
    });
  }
}
