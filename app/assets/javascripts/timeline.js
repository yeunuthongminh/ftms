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

var handle_data_timeline = function() {
  $('#timeline-embed .vco-storyjs a').each(function(index) {
    status = $(this).data('status');
    $($('#timeline-embed .vco-timeline .vco-navigation .timenav .content .marker .flag .flag-content')[index])
      .addClass(status + '-background-color');
    $($('#timeline-embed .vco-timeline .vco-navigation .timenav .content .marker .flag .flag-content h3')[index])
      .addClass(status + '-color');
  })
  $('#timeline-embed .vco-slider .slider-item .content .content-container .media .media-wrapper .media-container .plain-text .container .user_task').each(function() {
    if ($('.status', this).length == 0) {
      status_class = $('.task', this).data('finish') ? 'glyphicon glyphicon-check' :
        'glyphicon glyphicon-unchecked';
      html = '<div class="status pull-right"><i class="' + status_class + '"></i></div>';
      $(this).append(html);
    }
  });
}
