class SubjectsController < ApplicationController
  before_action :load_user
  before_action :load_subject

  def show
    if (authorize @user) && (authorize @subject)
      @subject_supports = Supports::SubjectTrainee.new subject: @subject,
        user_course_id: params[:user_course_id]
    else
      redirect_to root_path
    end
  end
end
