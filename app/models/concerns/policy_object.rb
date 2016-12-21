module PolicyObject
  Settings.functions.each do |function_name|
    define_method "#{function_name}?" do
      (@user.email == "admin@tms.com" && @user.current_role_type == "admin") ||
        @user.has_function?(@controller_name, @action, @user.current_role_type)
    end
  end

  def new?
    create?
  end

  def edit?
    update?
  end
end
