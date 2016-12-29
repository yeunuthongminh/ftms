class Admin::ProjectRequirementsController < ApplicationController
  before_action :authorize
  before_action :load_project, except: [:index, :create]

  def index
    @requirements = ProjectRequirement.select(:id, :name)
      .where project_id: params[:project_id]
    if params[:course_subject]
      subject_requirements = CourseSubjectRequirement.where(course_subject_id: params[:course_subject])
        .pluck(:project_requirement_id, :id).to_h
    end
    render json: {requirement: @requirements, subject_requirements: subject_requirements}
  end

  def create
    @requirement = ProjectRequirement.new params_requirement
    render json: {requirement: @requirement, new: "requirement"},
      status: @requirement.save ? 200 : 400
  end

  def update
    render json: nil, status: @requirement.update_attributes(params_requirement) ? 200 : 400
  end

  def destroy
    render json: nil, status: @requirement.destroy ? 200 : 400
  end

  private
  def params_requirement
    params.require(:project_requirement).permit :name, :project_id
  end

  def load_project
    @requirement = ProjectRequirement.find_by id: params[:id]
    unless @requirement
      redirect_to admin_projects_path
      flash[:alert] = flash_message "not_find"
    end
  end
end
