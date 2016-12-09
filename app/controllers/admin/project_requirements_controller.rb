class Admin::ProjectRequirementsController < ApplicationController

  def index
    @requirements = ProjectRequirement.select(:id, :name)
      .where project_id: params[:project_id]
    render json: @requirements
  end
end
