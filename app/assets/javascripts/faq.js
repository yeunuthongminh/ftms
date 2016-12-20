$(document).on('turbolinks:load', function () {
  var $tabs = $('.main-tabs');
  if($tabs.length > 0) {
    var selected_tab = $tabs.data('selected-tab');
    if(selected_tab != ''){
      $tabs.find('a[href="#' + selected_tab + '"]').tab('show');
    }
  }
});
