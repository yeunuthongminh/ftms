class Admin::ProjectsController < ApplicationController
  load_and_authorize_resource

  def index

  end

  def new

  end

  def create

  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def project_params
    params.require(:project).permit Project::ATTRIBUTES_PARAMS
  end
end
