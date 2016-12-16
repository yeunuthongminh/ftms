class Admin::RolesController < ApplicationController
  before_action :authorize
  before_action :load_role, only: [:update, :destroy]
  before_action :load_role_edit, only: :edit

  def index
    respond_to do |format|
      format.html {add_breadcrumb_index "roles"}
      format.json {
        render json: RolesDatatable.new(view_context, @namespace, current_user)
      }
    end
  end

  def new
    @role = Role.new
    @supports = Supports::RoleSupport.new @role
    add_breadcrumb_path "roles"
    add_breadcrumb_new "roles"
  end

  def create
    @role = Role.new role_params
    if @role.save
      flash[:success] = flash_message "created"
      redirect_to admin_roles_path
    else
      flash[:failed] = flash_message "not_created"
      render :new
    end
  end

  def edit
    @supports = Supports::RoleSupport.new @role
    add_breadcrumb_path "roles"
    add_breadcrumb @role.name
    add_breadcrumb_edit "roles"
  end

  def update
    if @role.update_attributes role_params
      add_user_function
      flash[:success] = flash_message "updated"
      redirect_to admin_roles_path
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

  def add_user_function
    user_functions = []
    @role.role_type.classify.constantize.all.each do |user|
      user.user_functions.delete_all
      @role.functions.each do |function|
        user_functions << UserFunction.new(function: function,
          role_type: @role.role_type, user: user)
      end
    end
    UserFunction.import user_functions
  end

  def load_role_edit
    @role = Role.includes(:functions).find_by id: params[:id]
    unless @role
      flash[:alert] = flash_message "not_find"
      back_or_root
    end
  end
end
