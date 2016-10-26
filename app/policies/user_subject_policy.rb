class UserSubjectPolicy < ApplicationPolicy
  attr_reader :current_user, :user_subject

  def initialize current_user, user_subject
    @current_user = current_user
    @user_subject = user_subject
  end

  def update?
    @current_user.is_trainee? && @current_user == @user_subject.user
  end
end
