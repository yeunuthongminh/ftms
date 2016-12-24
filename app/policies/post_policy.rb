class PostPolicy < ApplicationPolicy
  include PolicyObject

  def update?
    @user == @record.user
  end

  def destroy?
    @user.is_admin? || @user == @record.user
  end
end
