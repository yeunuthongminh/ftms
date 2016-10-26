class SubjectPolicy < ApplicationPolicy
  attr_reader :current_user, :subject

  def initialize current_user, subject
    @current_user = current_user
    @subject = subject
  end

  def show?
    @current_user.is_trainee?
  end
end
