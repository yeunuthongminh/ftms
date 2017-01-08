$(document).on('turbolinks:load', function() {
  $(document).on('click', '.cannot-vote', function(e) {
    e.preventDefault();
    alert(I18n.t('faq.votes.cannot_vote'));
  });
});
