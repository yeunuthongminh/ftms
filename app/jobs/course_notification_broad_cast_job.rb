class CourseNotificationBroadCastJob < ApplicationJob
  queue_as :default

  def perform args
    if args[:user_subject]
      notification = args[:user_subject].notifications.create key: args[:key],
        user_id: args[:user_id]
      notify_content = "#{I18n.t "layouts.subject"}
        #{I18n.t "notifications.keys.#{notification.key}",
        data: notification.trackable.course_subject.subject_name}
        #{I18n.t "user_subjects.notifications.user", user: notification.user.name}"
    else
      notification = args[:course].notifications.create key: args[:key],
        user_id: args[:user_id]
      notify_content = "#{I18n.t "layouts.course"}
        #{I18n.t "notifications.keys.#{notification.key}",
        data: notification.trackable.name}"
    end

    args[:course].users.each do |user|
      notification.user_notifications.create user: user
    end

    BroadCastService.new(notification, "channel_course_notification_#{args[:course].id}",
      notify_content).broadcast
  end
end
