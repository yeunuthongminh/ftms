module TaskHelper
  def user_task_action status
    html = ""
    actions = case status
      when "init"
        %w(inprogress edit delete)
      when "inprogress"
        %w(complete onhold edit delete)
      when "onhold"
        %w(complete edit delete)
      when "complete"
        %w(edit delete)
      end
    actions.each do |action|
      html += "<li><a href='#' class='task-action' data-action='"+action +"'>" +
        t("user_tasks.title.#{action}") + "</a></li>"
    end
    html
  end
end
