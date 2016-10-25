class UsersMailer < ApplicationMailer

  def mail_by_day user_id
    user = User.includes(courses: [course_subjects: [:subject,
      user_subjects: [:user, user_tasks: [:task, :user_task_histories]]]])
      .find_by id: user_id
    if user.present? && user.courses.progress.any?
      @courses = user.courses.progress
      mail to: user.email, subject: t("mail.by_day.title", time: Date.today)
    end
  end
end
