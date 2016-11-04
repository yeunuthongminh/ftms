class TaskPolicy < ApplicationPolicy
  attr_reader :user, :controller, :action, :user_functions, :record

  def initialize user, args
    @user = user
    @controller_name = args[:controller]
    @action = args[:action]
    @user_functions = args[:user_functions]
    @record = args[:record]
  end

  def update?
    if @user.is_trainee?
      Task::ATTRIBUTES_PARAMS
    end
  end

  def create?
    @user.is_trainee? && @record.create_by_trainee = @user.is_trainee?
  end
end
