class Trainer::CoursesController < ApplicationController
  include FilterData

  before_action :find_course_in_show, only: [:show, :destroy]
  before_action :find_course_in_edit, only: [:edit, :update]
  before_action :load_data, only: [:new, :edit, :show]
  before_action :authorize

  def index
    @supports = Supports::CourseSupport.new namespace: @namespace,
      filter_service: load_filter
  end

  def new
    @course.documents.build
  end

  def create
    if @course.save
      flash[:success] = flash_message "created"
      redirect_to trainer_courses_path
    else
      flash[:failed] = flash_message "not_created"
      load_data
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @course.update_attributes course_params
      flash[:success] = flash_message "updated"
      redirect_to trainer_course_path(@course)
    else
      flash[:failed] = flash_message "not_updated"
      load_data
      render :edit
    end
  end

  def destroy
    if @course.destroy
      flash[:success] = flash_message "deleted"
    else
      flash[:failed] = flash_message "not_deleted"
    end
    redirect_to trainer_courses_path
  end

  private
  def course_params
    params.require(:course).permit Course::COURSE_ATTRIBUTES_PARAMS
  end

  def load_data
    @course ||= Course.new
    @supports = Supports::CourseSupport.new course: @course
  end

  def find_course_in_show
    @course = Course.includes(:language, :trainers, :trainees,
      trainee_courses: :trainee_evaluations).find_by id: params[:id]
    redirect_if_object_nil @course
  end

  def find_course_in_edit
    @course = Course.includes(:documents).find_by_id params[:id]
    redirect_if_object_nil @course
  end
end
