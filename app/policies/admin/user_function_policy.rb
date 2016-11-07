class Admin::UserFunctionPolicy < ApplicationPolicy
  attr_reader :user, :controller, :action, :user_functions, :record

  def initialize user, args
    @user = user
    @controller_name = args[:controller]
    @action = args[:action]
    @user_functions = args[:user_functions]
    @record = args[:record]
  end

  Settings.all_functions.each do |function_name|
    define_method "#{function_name}?" do
      @user.has_role?(Settings.namespace_roles.admin) ||
        @user.has_function?(@controller_name, @action)
    end
  end

  # neu co class = admin => co tat ca cac quyen
  # neu class = trainer && role_type = admin => van la trainer nhung co role_function la cua admin
    #=> check user_function
end
