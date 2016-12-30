class Trainer::TasksController < ApplicationController
  before_action :load_course_subject
  before_action :load_task, except: [:new, :create]
  before_action :authorize
  before_action :add_task_info, only: [:create]

  def new
    @task = Task.new
    load_breadcrumbs
    add_breadcrumb t("breadcrumbs.subjects.new_task")
  end

  def edit
    load_breadcrumbs
    add_breadcrumb @task.name,
      trainer_course_subject_task_path(@course_subject, @task.user_tasks.first)
    add_breadcrumb t("breadcrumbs.subjects.edit")
  end

  def create
    @task = Task.build task_params
    if @task.save
      flash[:success] = flash_message "created"
      redirect_to edit_trainer_course_course_subject_path(@course_subject.course,
        @course_subject)
    else
      flash[:failed] = flash_message "not_created"
      redirect_to :back
    end
  end

  def update
    @old_assigned_trainee = @task.assigned_trainee
    if @task.update_attributes task_params
      flash[:success] = flash_message "updated"
    else
      flash[:failed] = flash_message "not_updated"
    end
    unless params[:task][:assigned_trainee_id].nil?
      @task.change_user_task @old_assigned_trainee
    end
    redirect_to :back
  end

  def destroy
    if @task.destroy
      flash[:success] = flash_message "deleted"
      redirect_to trainer_course_subject_path(@course_subject.course,
        @course_subject.subject)
    else
      flash[:failed] = flash_message "not_deleted"
      redirect_to :back
    end
  end

  private
  def task_params
    params.require(:task).permit Task::ATTRIBUTES_PARAMS
  end

  def load_task
    @task = Task.find_by id: params[:id]
    redirect_if_object_nil @task
  end

  def load_breadcrumbs
    add_breadcrumb_path "courses"
    add_breadcrumb @course_subject.course_name,
      trainer_course_path(@course_subject.course)
    add_breadcrumb @course_subject.subject_name,
      trainer_course_subject_path(@course_subject.course, @course_subject.subject)
  end

  def add_task_info
    if current_user.is_trainer? || current_user.is_admin?
      @course_subject.user_subjects.each do |user_subject|
        user_subject.create_user_task_if_create_task @task
      end
    else
      @task.create_by_trainee = current_user.trainee?
    end
    @task.course_subject = @course_subject
  end

  def load_course
    @course = Course.find params[:course_id]
    if @course.nil?
      flash[:alert] = flash_message "not_find"
      redirect_to trainer_courses_path
    end
  end

  def load_course_subject
    @course_subject = CourseSubject.find_by id: params[:course_subject_id]
    if @course_subject.nil?
      flash[:alert] = flash_message "not_find"
      back_or_root
    end
  end
end

