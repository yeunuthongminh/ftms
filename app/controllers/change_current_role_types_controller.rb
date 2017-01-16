class ChangeCurrentRoleTypesController < ApplicationController

  def update
    role = params[:format]
    current_user.update_attributes current_role_type: params[:format]
    if role == "trainee"
      redirect_to root_path
    else
      redirect_to eval("#{role}_root_path")
    end
  end
end
