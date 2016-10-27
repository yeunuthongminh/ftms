class FeedBackPolicy < ApplicationPolicy
  attr_reader :current_user, :feedback

  def initialize current_user, feedback
    @current_user = current_user
    @feedback = feedback
  end

  def create?
    @current_user.is_trainee?
  end
end
