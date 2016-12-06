class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    current_user.courses.each do |course|
      stream_from "channel_course_notification_#{course.id}"

      course.user_subjects do |user_subject|
        stream_from "chanel_user_subject_#{user_subject.id}"
      end
    end
  end

  def unsubscribed
  end
end
