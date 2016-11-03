class UserFunctionPolicy < ApplicationPolicy
  attr_reader :user, :controller, :action

  def initialize user, args
    @user = user
    @controller = args[:controller]
    @action = args[:action]
  end

  Settings.all_functions.each do |function_name|
    define_method "#{function_name}?" do
      role = Role.find_by name: user.current_role
      if role.has_function?(controller, action)
        user.has_function?(controller, action)
      else
        false
      end
    end
  end
end
