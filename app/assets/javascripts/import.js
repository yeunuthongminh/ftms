$(document).on('turbolinks:load', function(){
  $('#loading-image').hide();
  $('#import-data input#import-submit').prop('disabled',true);
  $('#import-data input[type=file]').click(function(){
    $('#loading-image').show();
  });
  $('#file-select').on('change', function() {
    $('#loading-image').hide();
    var file_extension = this.files[0].name.split('.').pop().toLowerCase();
    var allowed_file = ['csv', 'xls', 'xlsx'];
    var found_index = $.inArray(file_extension, allowed_file);
    if(found_index < 0) {
      alert(I18n.t('import_data.not_allowed'));
      $('#import-data input[type=submit]').prop('disabled',true);
    }
    else{
      alert(I18n.t('import_data.allowed'));
      $('#import-data input[type=submit]').prop('disabled',false);
    }
  });
});
