class ApplicationMailer < ActionMailer::Base
  default from: ENV["MAILGUN_SMTP_USERNAME"]
end
