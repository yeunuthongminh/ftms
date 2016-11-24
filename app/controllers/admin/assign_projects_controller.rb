class Admin::AssignProjectsController < ApplicationController
  before_action :load_data

  def update
    if params[:course_subject] && @course_subject.update_attributes(course_subject_params)
      flash.now[:success] = flash_message "updated"
    else
      flash.now[:danger] = flash_message "not_updated"
    end
    respond_to do |format|
      format.js
    end
  end

  private
  def course_subject_params
    params.require(:course_subject).permit CourseSubject::PROJECT_ATTRIBUTES_PARAMS
  end

  def load_data
    @course_subject = CourseSubject.find_by id: params[:course_subject_id]
    redirect_if_object_nil @course_subject
    @project_name = Project.find_by(id: params[:course_subject][:project_id]).name
  end
end
