class UserTaskPolicy < ApplicationPolicy
  include PolicyObject

  def destroy?
    @user = @record.user
  end

  def update?
    @user = @record.trainee
  end
end
