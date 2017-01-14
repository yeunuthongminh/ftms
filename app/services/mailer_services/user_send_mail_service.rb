class MailerServices::UserSendMailService
  attr_reader :args

  def initialize args
    @user = args[:user]
  end

  def perform
    if Rails.env.production?
      WelcomeNewTraineeJob.perform @user, Settings.default_password
    end
  end
end
