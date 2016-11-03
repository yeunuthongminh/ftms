class Admin::AllocateFunctionsController < ApplicationController
  before_action :load_role
  before_action :authorize

  def edit
    add_breadcrumb_path "roles"
    add_breadcrumb @role.name
    add_breadcrumb_role_allocate_permissions
    add_breadcrumb_edit "roles"
  end

  def update
    if @role.update_attributes role_params
      flash[:success] = flash_message "updated"
    else
      flash[:danger] = flash_message "not updated"
    end
    redirect_to admin_roles_path
  end

  private
  def role_params
    params.require(:role).permit Role::ATTRIBUTES_PARAMS
  end

  def load_role
    @role = Role.find_by id: params[:role_id]
    unless @role
      redirect_to admin_roles_path
      flash[:alert] = flash_message "not_find"
    end
  end
end
