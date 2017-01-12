module LoadUserFunction
  def add_user_function
    user = @user_form.user
    type = user.type
    base = "Role_Base_" + type
    if type == "Admin"
      user.functions = Function.all
    else
      role = Role.find_by name: base
      UserRole.create! user: user, role: role
      user.functions = role.functions
    end
    user.user_functions.update_all type: type
  end
end
