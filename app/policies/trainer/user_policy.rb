class Trainer::UserPolicy < ApplicationPolicy
  include PolicyObject

  def show?
    (@user.has_function?(@controller_name, @action) &&
      @controller_name.split("/")[0] == "trainer") ||
      @user == @record
  end

  def edit?
    (@user.has_function?(@controller_name, @action) &&
      @controller_name.split("/")[0] == "trainer") ||
      @user == @record
  end

  def update?
    edit?
  end
end
