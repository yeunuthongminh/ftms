class Admin::StagesController < ApplicationController
  before_action :authorize
  before_action :load_stage, only: [:edit, :update, :destroy]

  def index
    @stages = Stage.all
  end

  def new
    @stage = Stage.new
  end

  def create
    @stage = Stage.new stage_params
    if @stage.save
      flash[:success] = flash_message "created"
      redirect_to admin_stages_path
    else
      render :new
    end
  end

  def edit
    @supports = Supports::StageSupport.new(profile: @user.profile, stage: @stage) if params[:user_id]
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

  def load_stage
    @stage = Stage.find_by id: params[:id]
    redirect_if_object_nil @stage
  end
end
