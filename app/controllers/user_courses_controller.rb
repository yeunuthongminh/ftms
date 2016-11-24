class UserCoursesController < ApplicationController
  before_action :find_user_course, only: :show
  authorize_resource only: :show

  def show
    @user_course_supports = Supports::UserCourseSupport.new @user_course
  end

  private
  def find_user_course
    @user_course = UserCourse.includes(:course).find_by_id params[:id]
    if @user_course.nil?
      flash[:alert] = flash_message "not_load"
      redirect_to courses_path
    end
  end
end
