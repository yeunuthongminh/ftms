class SubjectPolicy < ApplicationPolicy
  include PolicyObject

  def update?
    @user == @record.trainee
  end
end
