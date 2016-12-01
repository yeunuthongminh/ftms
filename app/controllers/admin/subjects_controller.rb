class Admin::SubjectsController < ApplicationController
  before_action :authorize
  before_action :find_subject_in_edit, only: [:edit, :update]
  before_action :load_subject
  before_action :load_data, only: :show
  before_action :load_subject_detail, only: [:edit]

  def index
    @subject = Subject.new
    respond_to do |format|
      format.html {add_breadcrumb_index "subjects"}
      format.json {
        render json: SubjectsDatatable.new(view_context, @namespace)
      }
    end
  end

  def show
    add_breadcrumb_path "courses"
    add_breadcrumb @supports.course.name, admin_course_path(@supports.course)
    add_breadcrumb @supports.course_subject.subject_name
  end

  def new
    @subject = Subject.new
    @subject.documents.build
    @subject.task_masters.build
    load_subject_detail
    add_breadcrumb_path "subjects"
    add_breadcrumb_new "subjects"
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = flash_message "created"
      redirect_to admin_subject_task_masters_path @subject
    else
      flash[:failed] = flash_message "not_created"
      render :new
    end
  end

  def edit
    add_breadcrumb_path "subjects"
    add_breadcrumb @subject.name, admin_subject_task_masters_path(@subject)
    add_breadcrumb_edit "subjects"
  end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = flash_message "updated"
      redirect_to admin_subject_task_masters_path @subject
    else
      flash[:failed] = flash_message "not_updated"
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      flash[:success] = flash_message "deleted"
    else
      flash.now[:failed] = flash_message "not_deleted"
    end
    respond_to do |format|
      format.html {redirect_to admin_subjects_path}
    end
  end

  private
  def subject_params
    params.require(:subject).permit Subject::SUBJECT_ATTRIBUTES_PARAMS
  end

  def load_data
    @supports = Supports::SubjectSupport.new subject: @subject,
      course_id: params[:course_id]
    redirect_if_object_nil @supports.course
  end

  def find_subject_in_edit
    @subject = Subject.includes(:documents, :task_masters)
      .find_by id: params[:id]
    redirect_if_object_nil @subject
  end

  def load_subject_detail
    if @subject.subject_detail.nil?
      @subject.build_subject_detail percent_of_questions: Settings.exams.percent_question.to_s
    end
    @categories = Category.all
  end

  def load_subject
    @subject = Subject.find_by id: params[:id]
  end
end
