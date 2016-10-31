class Admin::ChangeStatusCoursesController < ApplicationController
  load_and_authorize_resource :course

  def update
    key = case @course.status
    when "init"
      "start_course"
    when "progress"
      "finish_course"
    end
    @course.send "#{key}", current_user
    flash[:success] = flash_message "#{key}"

    Notifications::CourseNotificationBroadCastJob.perform_now course: @course,
      key: Notification.keys[key], user: current_user
    redirect_to [:admin, @course]
  end
end
