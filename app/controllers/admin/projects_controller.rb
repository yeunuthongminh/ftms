class Admin::ProjectsController < ApplicationController
  before_action :authorize
  before_action :load_project, except: [:index, :new, :create]

  def index
    add_breadcrumb_index "projects"
    @projects = Project.all
  end

  def new
    Settings.default_number_of_requirement
      .times {@project.project_requirements.build}
    add_breadcrumb_path "projects"
    add_breadcrumb_new "projects"
  end

  def show
    @requirements = @project.project_requirements
    respond_to do |format|
      format.html
      format.json {render json: {requirements: @requirements}.to_json}
    end
  end

  def create
    if @project.save
      flash[:success] = flash_message "created"
      if params[:commit].present?
        redirect_to admin_projects_path
      else
        redirect_to new_admin_project_path
      end
    else
      render :new
    end
  end

  def edit
    add_breadcrumb_path "projects"
    add_breadcrumb_edit "projects"
  end

  def update
    if @project.update_attributes params_projects
      flash[:success] = flash_message "updated"
      redirect_to admin_projects_path
    else
      render :edit
    end
  end

  def destroy
    if @project.destroy
      flash[:success] = flash_message "deleted"
    else
      flash[:error] = flash_message "not_deleted"
    end
    redirect_to admin_projects_path
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
