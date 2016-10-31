class SubjectsController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :subject, only: :show

  def show
    @subject_supports = Supports::SubjectTrainee.new subject: @subject,
      user_course_id: params[:user_course_id]
  end
end
