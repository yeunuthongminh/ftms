class Admin::TraineeEvaluationsController < ApplicationController
  before_action :authorize
  before_action :find_trainee_evaluation, only: [:edit, :update]
  before_action :load_data, except: [:index, :create, :update]
  before_action :check_trainee_evaluation, only: :new

  def new
    add_breadcrumb_path "trainee_evaluations"
    add_breadcrumb @supports.targetable.trainee_name, @supports.targetable
    add_breadcrumb_new "trainee_evaluations"
  end

  def create
    @trainee_evaluation = current_user.trainee_evaluations
      .build trainee_evaluation_params
    if @trainee_evaluation.save
      flash[:success] = flash_message "created"
      redirect_to [:admin, :trainee_evaluations]
    else
      load_data
      flash[:alert] = flash_message "not_created"
      render :new
    end
  end

  def edit
    add_breadcrumb_path "trainee_evaluations"
    add_breadcrumb @supports.targetable.trainee_name, @supports.targetable
    add_breadcrumb_edit "trainee_evaluations"
  end

  def update
    if @trainee_evaluation.update_attributes trainee_evaluation_params
      flash[:success] = flash_message "updated"
      redirect_to [:admin, :trainee_evaluations]
    else
      load_data
      flash[:alert] = flash_message "not_updated"
      render :edit
    end
  end

  private
  def trainee_evaluation_params
    params.require(:trainee_evaluation).permit TraineeEvaluation::ATTRIBUTES_PARAMS
  end

  def load_data
    targetable = if params[:user_subject_id]
      UserSubject.find_by id: params[:user_subject_id]
    else
      UserCourse.find_by id: params[:user_course_id]
    end
    if targetable
      @supports = Supports::TraineeEvaluationSupport.new trainee_evaluation:
        @trainee_evaluation || TraineeEvaluation.new, targetable: targetable
    else
      flash[:alert] = flash_message "not_find"
      redirect_to [:admin, :trainee_evaluations]
    end
  end

  def find_trainee_evaluation
    @trainee_evaluation = TraineeEvaluation.includes(:evaluation_check_lists)
      .find_by id: params[:id]
    unless @trainee_evaluation
      flash[:alert] = flash_message "not_find"
      redirect_to [:admin, :trainee_evaluations]
    end
  end

  def check_trainee_evaluation
    trainee_evaluation = TraineeEvaluation.find_by trainee_id: @supports
      .targetable.user_id, trainer: current_user,
      targetable: @supports.targetable
    if trainee_evaluation
      flash[:alert] = flash_message "has_exist"
      redirect_to [:edit, :admin, @supports.targetable, trainee_evaluation]
    end
  end
end
