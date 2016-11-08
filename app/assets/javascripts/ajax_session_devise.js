$(document).ready(function(){
  Authentication.callbackSubmit();
});

var Authentication = {
  callbackSubmit: function(){
    var form = this;

    $("#login-form").bind('ajax:success', function(e, response, status, xhr){
      if(response.success){
        window.location.reload();
      }else{
        form.errorsFromServer(response.data.message);
      }
    });
  },
  errorsFromServer: function(message){
    $("#input-append").val('');
    $(".error").html('<p>'+ message+ '</p>');
  }
}
