class CoursePolicy < ApplicationPolicy
  include PolicyObject
  def index?
    @user == @record.trainee
  end

  def show?
    @user == @record.trainee
  end
end
