class CoursesController < ApplicationController
  before_action :load_course, only: [:index]
  after_action :verify_authorized

  def index
    unless authorize @user_courses
      redirect_to root_path
    end
  end

  private
  def load_course
    @user_courses = current_user.user_courses.course_not_init
  end
end
