class Admin::ProjectRequirementsController < ApplicationController
  before_action :authorize
  before_action :load_project, except: [:index, :create]

  def index
    @requirements = ProjectRequirement.select(:id, :name)
      .where project_id: params[:project_id]
    render json: @requirements
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
    params.require(:project_requirement).permit :name
  end

  def load_project
    @requirement = ProjectRequirement.find_by id: params[:id]
    unless @requirement
      redirect_to admin_projects_path
      flash[:alert] = flash_message "not_find"
    end
  end
end
