class Notifications::AssignProjectNotificationBroadCastJob < ApplicationJob
  queue_as :default

  def perform args
    notification = args[:course_subject].notifications.create key: args[:key],
      user_id: args[:user].id, parameters: args[:parameters], user: args[:user]

    args[:course_subject].user_subjects.each do |user_subject|
      notification.user_notifications.create user_id: user_subject.user_id
    end

    notify_content = "#{I18n.t "layouts.assign_project"} #{args[:user].name}
    #{I18n.t "notifications.keys.#{notification.key}",
      course_subject: notification.trackable.subject_name,
      data_project_name: args[:parameters]}"

    BroadCastService.new(notification, "channel_course_project_#{args[:course_subject].id}",
      notify_content).broadcast
  end
end
