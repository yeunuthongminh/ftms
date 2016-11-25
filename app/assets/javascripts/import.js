var import_data = function() {
  $('.file-select').bind('change', function() {
    var file = this.files[0];
    var message;
    if (file.size > 0) {
      var allowed_file = ['csv', 'xlsx', 'xls'];
      message = I18n.t('imports.allowed_csv');

      if(not_allow_extension(file.name, allowed_file)) {
        alert(message);
        $(this).val('');
      }
    } else {
      message = I18n.t('imports.not_allow_size');
      alert(message);
      $(this).val('');
    }
  });
}

$(document).on('turbolinks:load', function(){
  import_data();
  $('#form-import-file').submit(function(){
    var file_inputs = $('input[type=file]');
    for (var i = 0; i < file_inputs.length; i++){
      var model = $('#' + file_inputs[i].id).data('model');
      $('#check-box-tag-file-select-' + model).prop('checked', true);
      $('#loading-image-' + model).removeClass('hidden');
    }
    return true;
  });

  $(document).on('change', '.check-box', function(){
    $('.check-box').not(this).prop('checked', false);
  });
});

function not_allow_extension(filename, exts) {
  return !(new RegExp('(' + exts.join('|').replace(/\./g, '\\.') + ')$', "i")).test(filename);
}
