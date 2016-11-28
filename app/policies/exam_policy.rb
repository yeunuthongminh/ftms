class ExamPolicy < ApplicationPolicy
  include PolicyObject
  def show?
    @user == @record.trainee
  end

  def update?
    @user == @record.trainee
  end
end
