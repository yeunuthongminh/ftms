class UserPolicy < ApplicationPolicy
  include PolicyObject

  def show?
    @user == @record
  end

  def edit?
    if @user == @record
      User::USER_ATTRIBUTES_PARAMS
    end
  end

  def update?
    edit?
  end
end
