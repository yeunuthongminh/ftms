class ExamPolicy < ApplicationPolicy
  attr_reader :current_user, :exam

  def initialize current_user, exam
    @current_user = current_user
    @exam = exam
  end

  def index?
    @current_user.present?
  end

  def show?
    @current_user.is_trainer? || @current_user.is_admin? || @current_user == @exam.user
  end

  def update?
    @current_user.is_trainee?
  end
end
