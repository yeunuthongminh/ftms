module Authorize
  def authorize_with_multiple args, policy
    pundit_policy = policy.new current_user, args
    query = "#{params[:action]}?"
    unless pundit_policy.public_send query
      error = Pundit::NotAuthorizedError.new "not allowed"
      raise error
    end
  end

  def authorize
    controller_name = page_params[:controller].split("/")
    namespace = controller_name[0]
    authorize_with_multiple page_params,
      "#{namespace.classify}::#{controller_name[1].classify}Policy"
      .safe_constantize
  end

  def page_params
    Hash[:controller, params[:controller], :action, params[:action],
      :user_functions, current_user.user_functions]
  end

  def user_not_authorized
    flash[:alert] = t "error.not_authorize"
    if current_user.current_role_type == "admin"
      redirect_to admin_root_path
    elsif current_user.current_role_type == "trainer"
      redirect_to trainer_root_path
    else
      redirect_to root_path
    end
  end
end
