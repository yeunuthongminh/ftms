class UserSubjectNotificationBroadCastJob < ApplicationJob
  queue_as :default

  def perform args
    notification = args[:user_subject].notifications.create key: args[:key],
      user_id: args[:user_id]

    notification.user_notifications.create user_id: args[:user_subject].user_id

    notify_content = "#{I18n.t "layouts.subject"}
      #{I18n.t "notifications.keys.#{notification.key}",
      data: notification.trackable.course_subject.subject_name}"

    BroadCastService.new(notification, "channel_user_subject_#{args[:user_subject].id}",
      notify_content).broadcast
  end
end
