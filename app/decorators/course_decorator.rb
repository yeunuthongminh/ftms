class CourseDecorator < Draper::Decorator
  delegate_all
  include ApplicationHelper, UsersMailerHelper

  def set_status
    "<span class='label-status #{set_background_color_status course.status}'>
      #{I18n.t "courses.labels.status.#{self.status}"}</span>".html_safe
  end

  def show_user_action
    show_html = "<div>#{I18n.t 'mail.by_day.course', name: self.name}</div>"
    user_tasks = load_user_tasks(self.id)
    if user_tasks.any?
      user = user_tasks.first.user
      subject = user_tasks.first.user_subject.subject
      show_html += "<span style='margin-left: 20px;'>
        #{I18n.t 'mail.by_day.user_name', user_name: user.name}
        #{I18n.t 'mail.by_day.subject_name', subject_name: subject.name}"
      user_tasks.each do |user_task|
        unless user_task.user.id == user.id
          user = user_task.user
          show_html += "<br></span><span style='margin-left: 20px;'>
            #{I18n.t 'mail.by_day.user_name', user_name: user.name}
            #{I18n.t 'mail.by_day.subject_name', subject_name: subject.name}"
        end
        unless user_task.user_subject.subject.id == subject.id
          show_html += "#{I18n.t 'mail.by_day.subject_name', subject_name: subject.name}"
        end
        show_html += "#{I18n.t 'mail.by_day.finish_task', task_name: user_task.task_name}"
      end
      show_html += "</span><br>"
    else
      show_html += "<div style='margin-left: 20px;'>
        #{I18n.t 'mail.by_day.no_task_finish'}</div><br>"
    end
    show_html.html_safe
  end
end
