class Trainer::ChangeStatusCoursesController < ApplicationController
  load_and_authorize_resource :course

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
      key:Notification.keys[key], user_id: current_user.id
    redirect_to [:trainer, @course]
  end
end
