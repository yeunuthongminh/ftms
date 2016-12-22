class CoursePolicy < ApplicationPolicy
  include PolicyObject
  def index?
    @user == @record
  end

  def show?
    @user == @record.trainee
  end
end
