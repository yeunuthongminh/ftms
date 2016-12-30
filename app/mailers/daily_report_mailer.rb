class DailyReportMailer < ApplicationMailer

  def daily_mail user_id
    trainer = Trainer.includes(courses: [course_subjects: [:subject,
      user_subjects: [:user, user_tasks: :task]]]).find_by id: user_id
    if trainer.present? && trainer.courses.progress.any?
      @courses = trainer.courses.progress
      mail to: trainer.email, subject: t("mail.by_day.title", time: Date.today)
    end
  end
end
