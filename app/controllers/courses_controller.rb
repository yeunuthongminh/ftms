class CoursesController < ApplicationController
  before_action :load_course, only: [:index]

  def index
    authorize_with_multiple page_params.merge(record: @user_courses.first), CoursePolicy
  end

  private
  def load_course
    @user_courses = current_user.user_courses.course_not_init
  end
end
