module LoadUserFunction
  def add_user_function
    user = @user_form.user
    type = user.type
    base = "Role base " + type
    if type == "Admin"
      user.functions = Function.all
    else
      role = Role.find_by name: base.humanize
      UserRole.create! user: user, role: role
      user.functions = role.functions
    end
    user.user_functions.update_all type: type
  end

  def change_type
    type = @user.type.constantize
    unless @user.is_a? type
      add_user_function
    end
  end
end
