class ChangeRole::UsersController < ApplicationController
  before_action :find_user
  before_action :authorize

  def edit
    @roles = Role.all
    @supports = Supports::UserFunctionSupport.new @role, @user
  end

  def update
    @user.user_functions.delete_all
    user_functions = []
    rebuild_params.each do |user_function_id|
      user_function = rebuild_params[user_function_id]
      if user_function[:_destroy] == "false"
        user_functions << UserFunction.new(user: @user,
          function_id: user_function[:function_id],
          type: user_function[:type])
      end
    end
    UserFunction.import user_functions
    redirect_to eval("edit_#{@namespace}_user_path(@user)")
  end

  private
  def user_params
    params.require(:user).permit role_ids: [], user_functions_attributes: [:id, :function_id,
      :user_id, :type, :_destroy]
  end

  def rebuild_params
    user_params[:user_functions_attributes]
  end

  def find_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:alert] = flash_message "not_find"
      back_or_root
    end
  end
end
