class DailyReportMailer < ApplicationMailer

  def daily_mail user_id
    trainer = Trainer.includes(courses: [course_subjects: [:subject,
      user_subjects: [:trainee, user_tasks: [:task, :user_task_histories]]]])
      .find_by id: user_id
    if trainer.present? && trainer.courses.progress.any?
      @courses = trainer.courses.progress
      mail to: trainer.email, subject: t("mail.by_day.title", time: Date.today)
    end
  end
end
