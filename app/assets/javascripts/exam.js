$(document).on('turbolinks:load ajaxComplete', function() {
  if ($('.show-exam').length > 0) {
    var countdown = function() {
      $('#clock').countdown({
        until: 90,
        format: I18n.t('exams.time.default'),
        onExpiry: function() {
          alert(I18n.t('js.alert'));
          $('.submit-time-out').trigger('click');
          $('.submit-time-out').hidden();
        }
      });
    }
  }
});
