class Notifications::CourseNotificationBroadCastJob < ApplicationJob
  queue_as :default

  def perform args
    notification = args[:course].notifications.create key: args[:key],
      user_id: args[:user].id
    notify_content = "#{I18n.t "layouts.course"}
      #{I18n.t "notifications.keys.#{notification.key}",
      data: notification.trackable.name} #{args[:user].name}"

    (args[:course].trainees + args[:course].trainers).each do |user|
      notification.user_notifications.create user: user
    end

    BroadCastService.new(notification, "channel_course_notification_#{args[:course].id}",
      notify_content).broadcast
  end
end
