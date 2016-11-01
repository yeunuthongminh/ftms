class Admin::ChangeStatusCoursesController < ApplicationController
  before_action :load_course, only: :update
  before_action :authorize

  def update
    key = case @course.status
    when "init"
      "start"
    when "progress"
      "finish"
    when "finish"
      "reopen"
    end

    @course.send "#{key}_course", current_user
    flash[:success] = flash_message "#{key}_course"

    CourseNotificationBroadCastJob.perform_now course: @course,
      key: Notification.keys[key], user_id: current_user.id
    redirect_to [:admin, @course]
  end
end
