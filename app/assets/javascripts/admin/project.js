$(document).on("turbolinks:load", function() {
  $('.project-item').click(function() {
    $that = $(this);
    $that.parent().find('li').removeClass('active');
    $that.addClass('active');
    var id = $(this).data("prj");
    $.ajax({
      url: "projects/"+id+"/project_requirements",
      method: "GET",
      dataType: "json",
      success: function(data) {
        var html = "";
        var j = 0;

        if (data.length > 0) {
          data.forEach(function(requirement){
            j++;
            html += "<li type='1' class='list-group-item requirement-item' data-rqm="
              + requirement.id + ">" + j + ".&nbsp;&nbsp;" + requirement.name
              + "<div class='action'>\
              <a href='#' class='edit' title='Edit'><i class='fa fa-pencil'></i></a>\
              <a href='#' class='delete' title='Delete'><i class='fa fa-remove'></i></a>\
              </div></li>";
          });
        } else {
          html = "<div class='empty'><h2>" + I18n.t("projects.label.empty") + "</h2></div>"
        }

        $('#list-rqms').html(html);
        $('#sumRequirement b').html(j);
      },
      error: function() {
      }
    });
  });
});
