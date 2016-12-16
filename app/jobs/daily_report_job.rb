class DailyReportJob < ApplicationJob
  queue_as :default

  MAIL_DAY = 1

  def perform action, user_id
    case action
    when MAIL_DAY
      send_email_by_day user_id
    end
  end

  private
  def send_email_by_day user_id
    DailyReportMailer.daily_mail(user_id).deliver_now
  end
end
