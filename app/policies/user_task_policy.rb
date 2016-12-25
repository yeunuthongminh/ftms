class UserTaskPolicy < ApplicationPolicy
  include PolicyObject

  def destroy?
    @user == @record.trainee
  end

  def update?
    @user == @record.trainee
  end
end
