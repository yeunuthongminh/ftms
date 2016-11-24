class Admin::QuestionsController < ApplicationController
  load_and_authorize_resource
  include FilterData

  before_action :load_data, only: [:new, :edit]
  before_action :load_filter, only: :index


  def index
    questions = Question.includes :category
    @question_presenters = QuestionPresenter.new(questions, @namespace).render
  end

  def new
    Settings.default_number_of_answers.times {@question.answers.build}
    add_breadcrumb_path "questions"
    add_breadcrumb_new "questions"
  end

  def create
    if @question.save
      flash[:success] = flash_message "created"
      if params[:commit].present?
        redirect_to admin_questions_path
      else
        redirect_to new_admin_question_path
      end
    else
      load_data
      render :new
    end
  end

  def edit
    add_breadcrumb_path "questions"
    add_breadcrumb_edit "questions"
  end

  def update
    if @question.update_attributes params_questions
      flash[:success] = flash_message "updated"
      redirect_to admin_questions_path
    else
      load_data
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
  def params_questions
    params.require(:question).permit Question::ATTRIBUTES_PARAMS
  end

  def load_data
    @supports = Supports::QuestionSupport.new @question
  end
end
