$(document).on('turbolinks:load', function() {
  if ($('#exams').length > 0) {
    $('#clock').countdown({
      until: $('#remaining_time').val(),
      format: I18n.t('exams.time.default'),
      onExpiry: function() {
        $('.submit-time-out').trigger('click');
        $('.submit-time-out').hidden();
      }
    });
  }
});
