class UserTasksController < ApplicationController
  load_and_authorize_resource

  def update
    new_status = params[:status]
    @old_status = @user_task.status
    user_task_service = MailerServices::UserTaskService.new user_task: @user_task,
      status: new_status
    if new_status == Settings.status.finished
      @user_task_history = user_task_service.perform
      if @user_task.update_attributes status: Settings.status.finished
        flash.now[:success] = flash_message "updated"
      else
        flash.now[:error] = flash_message "not_updated"
      end
    else
      if user_task_service.perform
        flash.now[:success] = flash_message "updated"
      else
        flash.now[:error] = flash_message "not_updated"
      end
    end
    track_activity
    load_data
    respond_to do |format|
      format.js
    end
  end

  private
  def track_activity
    new_status = @user_task.status
    unless @old_status == new_status
      @user_task.create_activity key: "user_task.change_status",
        owner: current_user, parameters: {old_status: @old_status,
        new_status: new_status}
    end
  end

  def load_data
    @subject_supports = Supports::SubjectTrainee.new subject: @user_task
      .user_subject.subject, user_course_id: @user_task.user_subject
      .user_course_id
  end
end
