class Admin::ProjectsController < ApplicationController
  before_action :authorize
  before_action :load_project, except: [:index, :create]

  def index
    @projects = Project.all
    add_breadcrumb_index "projects"
  end

  def create
    @project = Project.new params_projects
    @requirements = ProjectRequirement.where project_id: @project.id
    render json: {project: @project, requirements: @requirements, new: "project"},
      status: @project.save ? 200 : 400
  end

  def update
    render json: nil, status: @project.update_attributes(params_projects) ? 200 : 400
  end

  def destroy
    render json: nil, status: @project.destroy ? 200 : 400
  end

  private
  def params_projects
    params.require(:project).permit Project::ATTRIBUTES_PARAMS
  end

  def load_project
    @project = Project.find_by id: params[:id]
    unless @project
      redirect_to admin_projects_path
      flash[:alert] = flash_message "not_find"
    end
  end
end
