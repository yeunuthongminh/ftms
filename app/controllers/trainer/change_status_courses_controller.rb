class Trainer::ChangeStatusCoursesController < ApplicationController
  before_action :authorize
  before_action :load_course

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

    Notifications::CourseNotificationBroadCastJob.perform_now course: @course,
      key:Notification.keys[key], user: current_user
    redirect_to [:trainer, @course]
  end
end
