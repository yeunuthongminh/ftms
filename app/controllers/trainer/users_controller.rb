class Trainer::UsersController < ApplicationController
  before_action :authorize, except: [:show, :edit, :update]
  before_action :load_user, only: [:edit, :show, :update]
  before_action :load_profile, except: [:index, :show, :destroy]
  before_action :load_breadcrumb_edit, only: [:edit, :update]
  before_action :load_breadcrumb_new, only: [:new, :create]
  before_action :quick_create_profile, except: [:destroy, :show]

  def new
    @user = User.new
    build_profile
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = flash_message "created"
      if params[:commit].present?
        redirect_to trainer_training_managements_path
      else
        redirect_to new_trainer_user_path
      end
    else
      render :new
    end
  end

  def edit
    authorize_with_multiple page_params.merge(record: @user), Trainer::UserPolicy
    build_profile unless @user.profile
  end

  def update
    authorize_with_multiple page_params.merge(record: @user), Trainer::UserPolicy
    if @user.update_attributes user_params
      sign_in(@user, bypass: true) if current_user? @user
      flash[:success] = flash_message "updated"
      redirect_to trainer_training_managements_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = flash_message "deleted"
    else
      flash[:alert] = flash_message "not_deleted"
    end
    redirect_to trainer_training_managements_path
  end

  def show
    authorize_with_multiple page_params.merge(record: @user), Trainer::UserPolicy
    add_breadcrumb_path "users"

    @activities = PublicActivity::Activity.includes(:owner, :trackable)
      .user_activities(@user.id).recent.limit(20).decorate
    @user_courses = @user.user_courses
    @finished_courses = @user_courses.course_finished
    @inprogress_course = @user_courses.course_progress.last

    if @inprogress_course
      @user_subjects = @inprogress_course.user_subjects
        .includes(course_subject: :subject).order_by_course_subject
    end

    @note = Note.new
    @note.author_id = current_user.id
    @note.user_id = @user.id
    @notes = Note.load_notes @user, current_user

    add_breadcrumb @user.name
  end

  private
  def user_params
    params.require(:user).permit User::ATTRIBUTES_PARAMS
  end

  def load_profile
    Settings.user_profiles.each do |data|
      instance_variable_set "@#{data.constantize.table_name}", data.constantize.all
    end
    @trainers = Trainer.all
  end

  def load_breadcrumb_edit
    add_breadcrumb_path "users"
    add_breadcrumb @user.name, [:trainer, @user]
    add_breadcrumb_edit "users"
  end

  def load_breadcrumb_new
    add_breadcrumb_path "users"
    add_breadcrumb_new "users"
  end

  def build_profile
    @user.build_profile
  end

  def quick_create_profile
    @location = Location.new
    @user_type = UserType.new
    @university = University.new
    @managers = User.not_trainees
  end
end
