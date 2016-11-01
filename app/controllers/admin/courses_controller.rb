class Admin::CoursesController < ApplicationController
  include FilterData

  before_action :find_course_in_show, only: :show
  before_action :find_course_in_edit, only: :edit
  before_action :load_data, only: [:new, :edit, :show]
  before_action :load_course, only: [:update, :destroy]
  before_action :authorize

  def index
    add_breadcrumb_index "courses"
    @supports ||= Supports::Course.new course: @course, namespace: @namespace,
      filter_service: load_filter
  end

  def new
    @course = Course.new
    @course.documents.build
    add_breadcrumb_path "courses"
    add_breadcrumb_new "courses"
  end

  def edit
    add_breadcrumb_path "courses"
    add_breadcrumb @course.name, :admin_course_path
    add_breadcrumb_edit "courses"
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = flash_message "created"
      redirect_to admin_course_path @course
    else
      flash[:failed] = flash_message "not_created"
      load_data
      render :new
    end
  end

  def show
    add_breadcrumb_path "courses"
    add_breadcrumb @course.name, :admin_course_path
  end

  def update
    if @course.update_attributes course_params
      ExpectedTrainingDateService.new(course: @course).perform
      flash[:success] = flash_message "updated"
      redirect_to admin_course_path(@course)
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
    redirect_to admin_courses_path
  end

  private
  def course_params
    params.require(:course).permit Course::COURSE_ATTRIBUTES_PARAMS
  end

  def load_data
    @supports ||= Supports::Course.new course: @course
  end

  def load_course
    @course = Course.find_by id: params[:id]
    redirect_if_object_nil @course
  end

  def find_course_in_show
    @course = Course.includes(:programming_language).find_by id: params[:id]
    redirect_if_object_nil @course
  end

  def find_course_in_edit
    @course = Course.includes(:documents).find_by id: params[:id]
    redirect_if_object_nil @course
  end
end
