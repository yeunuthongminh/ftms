class SubjectsController < ApplicationController
  before_action :load_subject

  def show
    authorize_with_multiple page_params.merge(record: @subject), SubjectPolicy
    @subject_supports = Supports::SubjectTraineeSupport.new subject: @subject,
      user_course_id: params[:user_course_id]
    add_breadcrumb_path "courses"
    add_breadcrumb @subject_supports.user_course.course.name,
      @subject_supports.user_course
    add_breadcrumb @subject.name
  end
end
