class UserMailer < ApplicationMailer
  default from: Settings.default_email

  def welcome_mail user, default_password
    @content = {name: user.name, email: user.email, password: default_password}
    mail to: user.email, subject: t("user_mailer.welcome_mail.subject")
  end
end
