class UserTasksController < ApplicationController
  before_action :load_user_task
  before_action :authorize_user_task

  def show
    respond_to do |format|
      format.js
    end
  end

  def update
    if params[:status]
      old_status = @user_task.status
      if @user_task.update_attributes status: params[:status]
        @user_task.create_activity key: "user_task.change_status",
          owner: current_user, parameters: {old_status: old_status,
          new_status: @user_task.status}
        flash.now[:success] = flash_message "updated"
      else
        flash.now[:error] = flash_message "not_updated"
      end
      load_data
      respond_to do |format|
        format.js
        format.json do
          render json: {status: 200}
        end
      end
    else
      if @user_task.update_attributes status: params[:status]
        flash.now[:success] = flash_message "updated"
      else
        flash.now[:error] = flash_message "not_updated"
      end
    end
  end

  private
  def load_data
    @subject_supports = Supports::SubjectTrainee.new subject: @user_task
      .user_subject.subject, user_course_id: @user_task.user_subject
      .user_course_id
  end

  def authorize_user_task
    authorize_with_multiple page_params.merge(record: @user_task), UserTaskPolicy
  end
end
