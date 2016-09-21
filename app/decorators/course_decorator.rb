class CourseDecorator < Draper::Decorator
  delegate_all
  include ApplicationHelper, UsersMailerHelper

  def set_status
    "<span class='label-status #{set_background_color_status course.status}'>
      #{I18n.t "courses.labels.status.#{self.status}"}</span>".html_safe
  end

  def show_user_action number
    show_html = "<div>#{number}: #{I18n.t 'mail.by_day.course',
      name: self.name}</div>"
    user_tasks = load_user_tasks(self.id)
    if user_tasks.any?
      user = user_tasks.first.user
      subject = user_tasks.first.user_subject.subject
      show_html += "<table><tr><td style='font-weight: bold;'>
        #{I18n.t 'mail.by_day.name'}</td>
        <td style='font-weight: bold;'>#{I18n.t 'mail.by_day.subject'}</td>
        <td style='font-weight: bold;'>
        #{I18n.t 'mail.by_day.task_finish'}</td></tr>
        <tr><td style='border: 1px solid #cecece;'>
        #{I18n.t 'mail.by_day.user_name', user_name: user.name}</td>
        <td style='border: 1px solid #cecece;'>
        #{I18n.t 'mail.by_day.subject_name',
        subject_name: subject.name,
        progress: user_tasks.first.user_subject.percent_progress.to_i}</td><td style='border: 1px solid #cecece;'>"
      user_tasks.each do |user_task|
        unless user_task.user.id == user.id
          user = user_task.user
          subject = user_task.user_subject.subject
          show_html += "</tr><tr></td>
            <td style='border: 1px solid #cecece;'>#{I18n.t 'mail.by_day.user_name', user_name: user.name}</td>
            <td style='border: 1px solid #cecece;'>#{I18n.t 'mail.by_day.subject_name',
            subject_name: subject.name,
            progress: user_task.user_subject.percent_progress.to_i}</td>
            <td style='border: 1px solid #cecece;'>"
        end
        unless user_task.user_subject.subject.id == subject.id
          subject = user_task.user_subject.subject
          show_html += "<tr><td></td>
            <td style='border: 1px solid #cecece;'>
            #{I18n.t 'mail.by_day.subject_name',
            subject_name: subject.name,
            progress: user_task.user_subject.percent_progress.to_i}</td>
            <td style='border: 1px solid #cecece;'>"
        end
        show_html += "#{I18n.t 'mail.by_day.finish_task',
          task_name: user_task.task_name}<br>"
      end
      show_html += "</tr></table>"
    else
      show_html += "<div style='margin-left: 20px;'>
        #{I18n.t 'mail.by_day.no_task_finish'}</div><br>"
    end
    show_html.html_safe
  end
end
