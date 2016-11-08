module PolicyObject
  Settings.all_functions.each do |function_name|
    define_method "#{function_name}?" do
      @user.has_function? @controller_name, @action
    end
  end
end
