class Admin::CourseSubjectsController < ApplicationController
  before_action :authorize
  before_action :load_course
  before_action :load_course_subject, except: :index

  def index
    @course_subjects = @course.course_subjects
  end

  def edit
    add_breadcrumb_path "courses"
    add_breadcrumb @course_subject.course_name, admin_course_path(@course)
    add_breadcrumb @course_subject.subject_name, admin_course_subject_path(@course,
      @course_subject.subject)
    add_breadcrumb_edit "subjects"
  end

  def update
    if @course_subject.update_attributes course_subject_params
      flash[:success] = flash_message "updated"
      redirect_to admin_course_subject_path @course, @course_subject.subject
    else
      flash[:failed] = flash_message "not_updated"
      render :edit
    end
  end

  def destroy
    if @course_subject.destroy
      flash[:success] = flash_message "deleted"
    else
      flash[:failed] = flash_message "not_deleted"
    end
    redirect_to admin_course_path @course
  end

  private
  def course_subject_params
    params.require(:course_subject).permit CourseSubject::ATTRIBUTES_PARAMS
  end

  def load_course
    @course = Course.find_by id: params[:course_id]
    redirect_if_object_nil @course
  end
end
