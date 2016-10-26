class UserPolicy < ApplicationPolicy
  attr_reader :current_user, :user

  def initialize current_user, user
    raise Pundit::NotAuthorizedError,I18n.t("flashs.user.mustlogin") unless current_user
    @current_user = current_user
    @user = user
  end

  def show?
    true
  end

  def edit?
    yourself?
  end

  def update?
    if yourself?
      User::USER_ATTRIBUTES_PARAMS
    end
  end

  private
  def yourself?
    @user == @current_user
  end
end
