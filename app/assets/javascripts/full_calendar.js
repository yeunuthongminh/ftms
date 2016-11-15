$(document).on('turbolinks:load', function() {
  $('#calendar').fullCalendar({
    theme: true,
    header: {
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay,listMonth'
    },
    navLinks: true,
    editable: true,
    eventLimit: true,
    businessHours: {
      dow: [1, 2, 3, 4, 5]
    },
    events: {
      url: '/calendars.json',
      error: function() {
        $('#script-warning').show();
      }
    },
    loading: function(bool) {
      $('#loading').toggle(bool);
    }
  });
  var can = '';

  $.ajax({
    url: '/calendars.json',
    type: 'json',
    method: 'get',
    async: false,
    complete: function (data) {
      can = data.responseJSON;
    }
  });

  $('#tiny-calendar').fullCalendar({
    height: 'auto',
    theme: true,
    header: {
      left: 'prev,next',
      center: 'title',
      right: 'today'
    },
    dayRender: function (date, cell){
      var dateObj = new Date(date);
      var current = dateObj.getFullYear()+ '-' +
        (dateObj.getMonth() + 1 < 10 ? '0' : '') +(dateObj.getMonth() + 1) + '-' +
        (dateObj.getDate() < 10 ? '0':'') + dateObj.getDate();
      $.each(can, function (i, v){
        if (current === v.end) {
          cell.css('background', 'red');
        }
      });
    },
    editable: true,
    fixedWeekCount: false,

    dayClick: function (date, allDay, jsEvent, view) {
      var date2 = new Date(date);
      var selectDate = date2.getFullYear()+ '-' +
        (date2.getMonth() + 1 < 10 ? '0' : '') +(date2.getMonth() + 1) + '-' +
        (date2.getDate() < 10 ? '0' : '') + date2.getDate();
      var chil = '';
      $.each(can, function (i, v){
        if (selectDate === v.end) {
          chil += I18n.t("calendars.must_be_finished") + v.title + '<br/>';
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
});
