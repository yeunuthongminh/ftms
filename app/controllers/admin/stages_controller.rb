class Admin::StagesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    if @stage.save
      flash[:success] = flash_message "created"
      redirect_to admin_stages_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @stage.update_attributes stage_params
      flash[:success] = flash_message "updated"
      redirect_to admin_stages_path
    else
      render :edit
    end
  end

  def destroy
    if @stage.destroy
      flash[:success] = flash_message "deleted"
    else
      flash[:failed] = flash_message "not_deleted"
    end
      redirect_to admin_stages_path
  end

  private
  def stage_params
    params.require(:stage).permit :name
  end
end
