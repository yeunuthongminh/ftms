$(document).on('turbolinks:load', function(){
  $('a.task-action').click(function (e) {
    e.preventDefault();
    var user_task_row = $(this).closest('.task.user-task-row'),
        action = $(this).data('action'),
        task_name = $('strong.task-name', user_task_row).text();
    if (action === "edit") {

    } else if (action === "delete") {

    } else {
      var popup_object = {
        id: user_task_row.attr('id'),
        large_modal: true,
        header_type: "dangerous",
        header_title: I18n.t("notices.attention"),
        body_content: I18n.t("user_tasks.title." + action + "_tasks", {task_name: task_name}),
        footer_btn: [
          {
            id: user_task_row.data('task'),
            class: "btn-danger " + action + "-task",
            title: I18n.t("buttons." + action + "s", {object: "task"}),
            dismiss: false
          },
          {
            class: "btn-secondary",
            title: I18n.t("buttons.cancel"),
            dismiss: true
          }
        ]
      };

      var confirm_modal = popup_html(popup_object);
      user_task_row.append(confirm_modal);
      $(confirm_modal).modal('show');
      $('.' + action + '-task').click(function (e) {
        e.preventDefault();
        var modal = $(this).closest('.modal');
        $.ajax({
          url: this.id,
          method: "PUT",
          data: {status: action},
          complete: function (data) {
            $(modal).modal('hide');
          }
        });
      });
    }
  });
});
