class Supports::UserFunctionSupport
  attr_reader :user_function, :current_user

  def initialize user_function, current_user
    @current_user = current_user
    @user_function = user_function
  end

  def presenter form
    @user_function ||= AddUserFunctionPresenter.new(form: form,
      user_functions: @current_user.user_functions).render
  end
end
