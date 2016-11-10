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

  private
  def load_course
    @course = Course.find_by id: params[:course_id]
    redirect_if_object_nil @course
  end
end
