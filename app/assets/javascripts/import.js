$(document).ready(function(){
  $('#loading-image').hide();
  $('input[type=submit]').prop('disabled',true);
  $('input[type=file]').on('click', function(){
    $('#loading-image').show();
  });
  $('#file-select').on('change', function() {
    $('#loading-image').hide();
    var file_extension = this.files[0].name.split('.').pop().toLowerCase();
    var allowed_file;
    allowed_file = ['csv', 'excel', 'excelx'];
    var found_index = $.inArray(file_extension, allowed_file);
    if(found_index < 0) {
      alert(I18n.t('import_data.not_allowed'));
      $('input[type=submit]').prop('disabled',true);
    }
    else{
      alert(I18n.t('import_data.allowed'));
      $('input[type=submit]').prop('disabled',false);
    }
  });
});
