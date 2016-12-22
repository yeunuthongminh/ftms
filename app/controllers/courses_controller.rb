class CoursesController < ApplicationController
  before_action :load_course, only: [:index]

  def index
    authorize_with_multiple page_params.merge(record: current_user), CoursePolicy
  end

  private
  def load_course
    @user_courses = current_user.user_courses.course_not_init
      .includes course: :language
  end
end
