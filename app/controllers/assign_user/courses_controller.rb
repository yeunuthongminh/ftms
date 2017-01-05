class AssignUser::CoursesController < ApplicationController
  before_action :find_course
  before_action :authorize

  def edit
    @assign_user_form = AssignUserCourseForm.new @course
  end

  def update
    @assign_user_form = AssignUserCourseForm.new @course,
      user_courses_params[:user_courses_attributes].values
    @assign_user_form.save
  end

  private
  def user_courses_params
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
