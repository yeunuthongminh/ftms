class UsersController < ApplicationController
  before_action :authorize_user
  before_action :load_university, only: :edit
  before_action :load_data, only: :show
  before_action :load_user

  def show
    @supports = Supports::User.new @user
    add_breadcrumb @user.name
  end

  def edit
    @user.build_profile unless @user.profile
  end

  def update
    if @user.update_attributes user_params
      sign_in @user, bypass: true
      redirect_to @user, notice: flash_message("updated")
    else
      load_university
      flash[:alert] = flash_message "not_updated"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit User::ATTRIBUTES_PARAMS
  end

  def load_data
    @supports ||= Supports::User.new @user
  end

  def load_user
    @user = User.includes(:profile).find_by id: params[:id]
    if @user.nil?
      flash[:alert] = flash_message "not_find"
      redirect_to root_path
    end
  end

  def load_university
    @universities = University.all
  end

  def authorize_user
    authorize_with_multiple page_params.merge(record: current_user), UserPolicy
  end
end
