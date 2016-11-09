class Trainer::CoursePolicy < ApplicationPolicy
  attr_reader :user, :controller, :action, :user_functions, :record

  def initialize user, args
    @user = user
    @controller_name = args[:controller]
    @action = args[:action]
    @user_functions = args[:user_functions]
    @record = args[:record]
  end

  def index?
    true
  end

  def show?
    @user.has_function? @controller_name, @action
  end

  def new?
    @user.has_function? @controller_name, @action
  end

  def create?
    new?
  end

  def edit?
    @user.has_function? @controller_name, @action
  end

  def update?
    edit?
  end

  def destroy?
    @user.has_function? @controller_name, @action
  end
end
