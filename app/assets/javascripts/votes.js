$(document).on('turbolinks:load', function() {
  $(document).on('click', '.cannot-vote', function(e) {
    e.preventDefault();
    alert(I18n.t('qna.votes.cannot_vote'));
  });
});
