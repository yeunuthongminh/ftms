class UserTaskPolicy < ApplicationPolicy
  attr_reader :current_user, :user_task

  def initialize current_user, user_task
    @current_user = current_user
    @user_task = user_task
  end

  def destroy?
    @current_user.is_trainee? && @current_user == @user_task.user
  end

  def update?
    true
  end
end
