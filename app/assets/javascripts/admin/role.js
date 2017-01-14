$(document).on("turbolinks:load", function() {
  var tbl_role = $("#role-tbl");
  if(tbl_role.length > 0) {
    set_datatable(tbl_role, [0, 2, 3]);
  }

  $('.check_functions').change(function(){
    var $function_table = $(this).closest('.table')
      .find('.filter_table_right_part');
    var index = $(this).data('index');
    var checked = $(this).prop('checked');
    $('.trow', $function_table).each(function(){
      var $function = $(this).find('.checked-function')[index];
      if($function){
        $($function).find('input[type="checkbox"]')
          .prop("checked", checked);
      }
    });
  });

  $('.check_role_functions').change(function(){
    var role_id = $(this).val();
    var url = $(this).closest('form').attr('action') + '/edit';
    var checked = $(this).prop('checked');
    $.ajax({
      url: url,
      type: 'GET',
      dataType: 'json',
      data: {role_id: role_id},
      success: function(data){
        for(var i = 0; i < data.functions.length; i++){
          $('input[value="' + data.functions[i] + '"]').each(function(){
            if($(this).prev().val() == data.role_type) {
              $(this).next().find('input[type="checkbox"]')
                .prop("checked", checked);
            }
          });
        };
      }
    });
  });
});
