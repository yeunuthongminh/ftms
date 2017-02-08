class Api::SessionsController < Devise::SessionsController
  include Confirm

  skip_before_action :verify_authenticity_token
  skip_before_action :verify_signed_out_user
  
  before_action :ensure_params_exist, only: :destroy
  before_action :check_params_login, only: :create
  before_action :load_user_authentication

  respond_to :json

  def create
    if @user.valid_password? user_params[:password]
      sign_in @user, store: false
      render json: {message: t("authentication.sessions.sign_in_success"),
        data: {user: @user}, code: 1}, status: 200
      return
    end
    invalid_login_attempt
  end

  def destroy
    if @user.authentication_token == params[:user][:authentication_token]
      sign_out @user
      render json: {message: t("authentication.sessions.sign_out"),
        data: {}, code: 1}, status: 200
    else
      render json: {message: t("authentication.sessions.invalid_token"),
        data: {}, code: 0}, status: 200
    end
  end

  private
  def user_params
    params.require(:user).permit User::ATTRIBUTES_PARAMS
  end
  
  def invalid_login_attempt
    render json: {message: t("authentication.sessions.sign_in_fail"),
      data: {}, code: 0}, status: 200
  end

  def check_params_login
    return unless params[:user].blank? || params[:user][:email].blank? ||
      params[:user][:password].blank?
    render json: {message: t("authentication.error.missing_params"),
      data: {}, code: 0}, status: 422
  end
end
