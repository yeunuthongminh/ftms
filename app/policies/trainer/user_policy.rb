class Trainer::UserPolicy < ApplicationPolicy
  include PolicyObject

  def update?
    @user.has_function?(@controller_name, "update", @user.current_role_type)
  end

  def edit?
    update?
  end
end
