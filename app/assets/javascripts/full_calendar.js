$(document).on('turbolinks:load', function () {
  if ($('meta[name=current-user]').attr('id').length > 0) {
    if (localStorage.calendar_data == "undefined" || typeof localStorage.calendar_data === typeof undefined) {
      $.ajax({
        url: '/calendars.json',
        type: 'json',
        method: 'get',
        async: false,
        complete: function (data) {
          localStorage.setItem('calendar_data', JSON.stringify(data.responseJSON));
        }
      });
    }
  } else if (localStorage.calendar_data) {
    localStorage.removeItem('calendar_data');
  }
  $('#calendar').fullCalendar({
    theme: true,
    header: {
      left: 'prev, next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay,listMonth'
    },
    height: 'auto',
    navLinks: true,
    editable: true,
    eventLimit: 3,
    businessHours: {
      dow: [1, 2, 3, 4, 5]
    },
    events: {
      url: '/trainer/calendars.json',
      async: false,
      error: function () {
        $('#script-warning').show();
      }
    },
    loading: function (bool) {
      $('#loading').toggle(bool);
    },
    eventMouseover: function (event) {
      $(this).attr("title", event.title);
    },
    eventLimitClick: function (cellInfo, isEvent) {
      modal_calendar(cellInfo);
    }
  });

  $(window).on('resize', function () {
    width = $(window).width() - 600;
    $('#full_calendar_modal .modal .modal-dialog').css('width', width);
  });

  $('#tiny-calendar').fullCalendar({
    height: 'auto',
    theme: true,
    header: {
      left: 'prev,next',
      center: 'title',
      right: 'today'
    },
    dayRender: function (date, cell) {
      var dateObj = new Date(date);
      var current = dateObj.getFullYear() + '-' +
        (dateObj.getMonth() + 1 < 10 ? '0' : '') + (dateObj.getMonth() + 1) + '-' +
        (dateObj.getDate() < 10 ? '0' : '') + dateObj.getDate();
      $.each(JSON.parse(localStorage.calendar_data), function (i, v) {
        if (current === v.end) {
          cell.css('background', 'red');
        }
      });
    },
    editable: true,
    fixedWeekCount: false,

    dayClick: function (date, allDay, jsEvent, view) {
      var date2 = new Date(date);
      var selectDate = date2.getFullYear() + '-' +
        (date2.getMonth() + 1 < 10 ? '0' : '') + (date2.getMonth() + 1) + '-' +
        (date2.getDate() < 10 ? '0' : '') + date2.getDate();
      var chil = '';
      $.each(JSON.parse(localStorage.calendar_data), function (i, v) {
        if (selectDate === v.end) {
          chil += I18n.t("calendars.must_be_finished") + v.title + '<br/>';
          chil += "Task finished " + '<br/>';
          var arr = v.task_user.split('/');
          for (var i = 0; i < arr.length; i++) {
            chil += arr[i] + '<br/>';
          }
          ;
        }
      });
      $('#dialog').html(chil);
      $('#dialog').dialog('open');
    },
  });

  $('#dialog').dialog({
    autoOpen: false,
    height: 350,
    width: 500,
    header: 'Schedule',
    buttons: {
      OK: function () {
        $(this).dialog('close');
      }
    },
    close: function () {
    }
  });

  function modal_calendar(cellInfo) {
    var abc =
      '<div class="modal" id="modal_calendar fade" tabindex="-1" role="dialog"> \
        <div class="modal-dialog" role="document"> \
          <div class="modal-content"> \
            <div class="modal-header"> \
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"> \
                <span aria-hidden=/"true/">&times;</span> \
              </button> \
              <h4 class="modal-title">' + I18n.l("datetime.formats.default", cellInfo.date._d) + '</h4> \
          </div> \
          <div class="modal-body">\
            <ol>';
    for (var i = 0; i < cellInfo.segs.length; i++) {
      cell_segs = cellInfo.segs[i].event;
      abc += '<li style="color:' + cell_segs.color + '">' + cell_segs.title + '</li>';
    }
    abc += '</ol>\
          </div> \
          <div class="modal-footer"> \
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> \
          </div> \
        </div> \
      </div> \
    </div>';
    $('#full_calendar_modal').html(abc);
    $('#full_calendar_modal .modal').modal('show');
    var width = $(window).width() - 600;
    $('#full_calendar_modal .modal .modal-dialog').css('width', width);
  }
});
