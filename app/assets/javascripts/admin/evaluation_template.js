$(document).on('turbolinks:load', function() {
  $('.noneselected-evaluation-standards').on('click', '.list-group-item', function() {
    var evaluation_standard_form = "";
    var evaluation_standard_id = $(this).data("id");
    var evaluation_standard_name = $(this).data("name");

    $(this).remove();

    evaluation_standard_form += "<div class='list-group-item' data-id='" + evaluation_standard_id
      + "' data-name='" + evaluation_standard_name + "'>"
      + "<input class='hidden' type='checkbox' value='" + evaluation_standard_id
      + "' checked='checked' name='evaluation_template[evaluation_standard_ids][]'"
      + " id='evaluation_template_evaluation_standard_ids_" + evaluation_standard_id + "'>"
      + evaluation_standard_name + "</div>";

    $(".selected-evaluation-standards").prepend(evaluation_standard_form);
  });

  $('.selected-evaluation-standards').on('click', '.list-group-item', function() {
    var evaluation_standard = "";
    var evaluation_standard_id = $(this).data("id");
    var evaluation_standard_name = $(this).data("name");

    evaluation_standard += "<div class='list-group-item' data-id='" + evaluation_standard_id
      + "' data-name='" + evaluation_standard_name + "'>"
      + evaluation_standard_name + "</div>";
    $(".noneselected-evaluation-standards").prepend(evaluation_standard);
    $(this).remove();
  });

  $('.noneselected-list-standards').on('click', '.new-evaluation-standard', function() {
    $('#new-evaluation-standard-modal #selected').val(false);
  });

  $('.selected-list-standards').on('click', '.new-evaluation-standard', function() {
    $('#new-evaluation-standard-modal #selected').val(true);
  });

  $('#new-evaluation-standard-modal').on('show.bs.modal', function (e) {
    $('#new_evaluation_standard')[0].reset();
  });
});
