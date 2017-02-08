module Confirm
  def ensure_params_exist
   return unless params[:user].blank?
    render json: {message: t("authentication.error.missing_param"),
      data: {}, code: 0}, status: 422
  end

  def load_user_authentication
    @user = User.find_by_email user_params[:email]
    return login_invalid unless @user
  end

  def login_invalid
    render json: {message: t("authentication.error.invalid_login"),
      data: {}, code: 0}, status: 200
  end
end
