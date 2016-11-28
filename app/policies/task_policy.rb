class TaskPolicy < ApplicationPolicy
  include PolicyObject

  def update?
    if @user.is_trainee?
      Task::ATTRIBUTES_PARAMS
    end
  end

  def create?
    @user.is_trainee? && @record.create_by_trainee = @user.is_trainee?
  end
end
