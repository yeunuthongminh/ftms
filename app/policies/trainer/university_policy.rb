class Trainer::UniversityPolicy < ApplicationPolicy
  attr_reader :user, :controller, :action, :user_functions, :record
  include PolicyObject

  def initialize user, args
    @user = user
    @controller_name = args[:controller]
    @action = args[:action]
    @user_functions = args[:user_functions]
    @record = args[:record]
  end
end
