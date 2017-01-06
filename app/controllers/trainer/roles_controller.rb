class Trainer::RolesController < ApplicationController
  before_action :load_role, only: [:edit, :update, :destroy]
  before_action :authorize

  def index
    respond_to do |format|
      format.html
      format.json {
        render json: RolesDatatable.new(view_context, @namespace, current_user)
      }
    end
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new role_params
    if @role.save
      flash[:success] = flash_message "created"
      redirect_to trainer_roles_path
    else
      flash[:failed] = flash_message "not_created"
      render :new
    end
  end

  def edit
  end

  def update
    if @role.update_attributes role_params
      flash[:success] = flash_message "updated"
      redirect_to trainer_roles_path
    else
      flash[:failed] = flash_message "not_update"
      render :edit
    end
  end

  def destroy
    if @role.destroy
      flash[:success] = flash_message "deleted"
    else
      flash[:failed] = flash_message "not_deleted"
    end
    redirect_to :back
  end

  private
  def role_params
    params.require(:role).permit Role::ATTRIBUTES_ROLE_PARAMS
  end
end
