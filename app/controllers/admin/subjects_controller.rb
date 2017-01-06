class Admin::SubjectsController < ApplicationController
  before_action :authorize
  before_action :find_subject_in_edit, only: [:edit, :update]
  before_action :load_subject, only: [:show, :destroy]
  before_action :load_data, only: :show
  before_action :load_subject_detail, only: [:edit]

  def index
    @subject = Subject.new
    respond_to do |format|
      format.html
      format.json {
        render json: SubjectsDatatable.new(view_context, @namespace)
      }
    end
  end

  def show
  end

  def new
    @subject = Subject.new
    @subject.documents.build
    @subject.task_masters.build
    load_subject_detail
    @subject_form = SubjectForm.new @subject
  end

  def create
    @subject = Subject.new subject_params
    @subject_form = SubjectForm.new @subject
    if @subject_form.validate subject_params
      @subject_form.save
      flash[:success] = flash_message "created"
      redirect_to admin_subject_task_masters_path @subject
    else
      load_subject_detail
      flash[:failed] = flash_message "not_created"
      render :new
    end
  end

  def edit
    @subject_form = SubjectForm.new @subject
  end

  def update
    @subject_form = SubjectForm.new @subject
    if @subject_form.validate subject_params
      @subject_form.save
      flash[:success] = flash_message "updated"
      redirect_to admin_subject_task_masters_path @subject
    else
      load_subject_detail
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
    @categories = Category.includes(:questions).all
  end

  def load_subject
    @subject = Subject.find_by id: params[:id]
  end
end
