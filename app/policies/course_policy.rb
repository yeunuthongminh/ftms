class CoursePolicy < ApplicationPolicy
  include PolicyObject
  def index?
    @user.has_function?(@controller_name, @action) && @user == @record.trainee
  end

  def show?
    @user.has_function?(@controller_name, @action) && @user == @record.trainee
  end
end
