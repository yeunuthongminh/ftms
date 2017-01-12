class Admin::QuestionsController < ApplicationController
  before_action :authorize
  before_action :load_question, only: [:edit, :update, :destroy]

  include FilterData

  before_action :load_data, only: [:new, :edit]
  before_action :load_filter, only: :index


  def index
    questions = Question.includes :category
    @question_presenters = QuestionPresenter.new({questions: questions,
      namespace: @namespace}).render
  end

  def new
    @question = Question.new
    Settings.default_number_of_answers.times {@question.answers.build}
    @question_form = QuestionForm.new @question
    add_breadcrumb_path "questions"
    add_breadcrumb_new "questions"
  end

  def create
    @question = Question.new

    @question_form = QuestionForm.new @question
    if @question_form.validate question_params
      @question_form.save
      flash[:success] = flash_message "created"
      if params[:continue].present?
        redirect_to new_admin_question_path
      else
        redirect_to admin_questions_path
      end
    else
      load_data
      flash_message[:failed] = flash_message "not_created"
      render :new
    end
  end

  def edit
    @question_form = QuestionForm.new @question
  end

  def update
    @question_form = QuestionForm.new @question

    if @question_form.validate question_params
      @question_form.save
      flash[:success] = flash_message "updated"
      redirect_to admin_questions_path
    else
      load_data
      flash[:success] = flash_message "not_updated"
      render :edit
    end
  end

  def destroy
    if @question.destroy
      flash[:success] = flash_message "deleted"
    else
      flash[:alert] = flash_message "not_deleted"
    end
    redirect_to admin_questions_path
  end

  private
  def question_params
    params.require(:question).permit Question::ATTRIBUTES_PARAMS
  end

  def load_data
    @supports = Supports::QuestionSupport.new @question
  end

  def load_question
    @question = Question.find_by id: params[:id]
    unless @question
      redirect_to admin_questions_path
      flash[:alert] = flash_message "not_find"
    end
  end
end
