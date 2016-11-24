class Admin::ChangeRolesController < ApplicationController
  before_action :find_user
  before_action :authorize

  def index
    @roles = Role.all
  end

  def create
    if role_changed?
      @user.user_roles.delete_all
      @user.user_functions.delete_all
      @user.update_attributes role_ids: rebuild_params
      user_functions = []
      rebuild_params.each do |role_id|
        role = Role.find role_id
        role.role_functions.each do |role_function|
          user_functions << UserFunction.new(user: @user,
            function_id: role_function.function_id,
            role_type: role.role_type)
        end
      end
      UserFunction.import user_functions
    end
    redirect_to edit_admin_user_path(@user)
  end

  private
  def user_params
    params.require(:user).permit role_ids: []
  end

  def role_changed?
    @user.user_roles.collect{|u| u.role_id.to_s} != rebuild_params
  end

  def rebuild_params
    user_params[:role_ids] - [""]
  end

  def find_user
    @user = User.find_by id: params[:user_id]
  end
end
