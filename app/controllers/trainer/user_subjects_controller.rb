class Trainer::UserSubjectsController < ApplicationController
  before_action :authorize
  before_action :load_user_subject, only: [:update]

  def update
    if params[:user_subject].present?
      if @user_subject.update_attributes user_subject_params
        flash.now[:success] = flash_message "updated"
        update_end_date_when_update_start_date if params[:user_subject][:start_date]
          .present?
      else
        flash.now[:danger] = flash_message "not_updated"
      end
    else
      @user_subject.update_status current_user, params["status"]
    end
    load_data
    respond_to do |format|
      format.js
    end
  end

  private
  def user_subject_params
    params.require(:user_subject).permit UserSubject::ATTRIBUTES_PARAMS
  end

  def load_data
    @supports = Supports::UserSubjectSupport.new user_subject: @user_subject,
      course_subject_id: params[:course_subject_id]
    redirect_if_object_nil @supports.course_subject
  end

  def update_end_date_when_update_start_date
    @user_subject.update_attributes end_date:
      (@user_subject.during_time - 1).business_days.after(@user_subject.start_date)
  end

  def load_user_subject
    @user_subject = UserSubject.find_by id: params[:id]
    unless @user_subject
      redirect_to trainer_user_subjects_path
      flash[:alert] = flash_message "not_find"
    end
  end
end
