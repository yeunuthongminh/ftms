class TaskPolicy < ApplicationPolicy
  attr_reader :current_user, :task

  def initialize current_user, task
    @current_user = current_user
    @task = task
  end

  def create?
    current_user.is_trainee? && @task.create_by_trainee = current_user.is_trainee?
  end

  def update?
    if @current_user.is_trainee?
      Task::ATTRIBUTES_PARAMS
    end
  end
end
