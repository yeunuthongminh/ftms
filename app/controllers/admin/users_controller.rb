class Admin::UsersController < ApplicationController
  before_action :authorize
  before_action :load_user, except: [:index, :new, :create]
  before_action :load_profile, only: [:new, :edit, :show]
  before_action :load_breadcrumb_edit, only: [:edit, :update]
  before_action :load_breadcrumb_new, only: [:new, :create]

  def new
    @user = User.new
    build_profile
  end

  def create
    @user = User.new user_params
    user_send_mail_service = MailerServices::UserSendMailService.new user: @user
    if @user.save && user_send_mail_service.perform?
      flash[:success] = flash_message "created"
      if params[:create_and_continue].present?
        redirect_to admin_training_managements_path
      else
        redirect_to new_admin_user_path
      end
    else
      load_profile
      render :new
    end
  end

  def edit
    build_profile unless @user.profile
  end

  def update
    if @user.update_attributes user_params
      sign_in(@user, bypass: true) if current_user? @user
      flash[:success] = flash_message "updated"
      redirect_to admin_training_managements_path
    else
      load_profile
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = flash_message "deleted"
    else
      flash[:alert] = flash_message "not_deleted"
    end
    redirect_to admin_training_managements_path
  end

  def show
    @notes = Note.load_notes @user, current_user
    add_breadcrumb_path "users"
    add_breadcrumb @user.name
  end

  private
  def user_params
    params.require(:user).permit User::ATTRIBUTES_PARAMS
  end

  def load_profile
    @supports = Supports::UserSupport.new @user
  end

  def load_breadcrumb_edit
    add_breadcrumb_path "users"
    add_breadcrumb @user.name, [:admin, @user]
    add_breadcrumb_edit "users"
  end

  def load_breadcrumb_new
    add_breadcrumb_path "users"
    add_breadcrumb_new "users"
  end

  def build_profile
    @user.build_profile
  end

  def load_user
    @user = User.includes(:profile).find_by id: params[:id]
    if @user.nil?
      flash[:alert] = flash_message "not_find"
      redirect_to admin_training_managements_path
    end
  end
end
