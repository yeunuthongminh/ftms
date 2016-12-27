class AssignTrainer::CoursesController < ApplicationController
  before_action :find_course
  before_action :authorize

  def edit
    @supports = Supports::AssignUser.new course: @course
  end

  def update
    if params[:course] && @course.update_attributes(course_params)
      ExpectedTrainingDateService.new(course: @course).perform
      flash[:success] = flash_message "updated"
    else
      flash[:danger] = flash_message "not_updated"
    end
    redirect_to [@namespace.to_sym, @course]
  end

  private
  def course_params
    params.require(:course).permit Course::USER_COURSE_ATTRIBUTES_PARAMS
  end

  def find_course
    @course = Course.find_by id: params[:id]
    if @course.nil?
      flash[:alert] = flash_message "not_find"
      redirect_to [@namespace.to_sym, :courses]
    end
  end
end
