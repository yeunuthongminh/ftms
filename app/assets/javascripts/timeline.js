$(document).on('turbolinks:load', function() {
  if ($('#timeline-embed').length > 0) {
    $.ajax({
      url: '/timelines.json',
      type: 'json',
      method: 'get',
      complete: function(data) {
        createStoryJS({
          type: 'timeline',
          width: '100%',
          height: '600',
          source: '/timelines.json',
          embed_id: 'timeline-embed'
        });
      }
    });
  }
});
