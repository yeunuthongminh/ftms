class Admin::EvaluationStandardsController < ApplicationController
  before_action :authorize
  before_action :find_evaluation_standard, only: [:edit, :update, :destroy]

  def index
    @evaluation_standard = EvaluationStandard.new
    respond_to do |format|
      format.html {add_breadcrumb_index "evaluation_standards"}
      format.js
      format.json {
        render json: EvaluationStandardsDatatable.new(view_context, @namespace)
      }
    end
  end

  def new
    @evaluation_standard = EvaluationStandard.new
    add_breadcrumb_index "evaluation_standards"
    add_breadcrumb_new "evaluation_standards"
  end

  def edit
    add_breadcrumb_index "evaluation_standards"
    add_breadcrumb_edit "evaluation_standards"
  end

  def create
    @evaluation_standard = EvaluationStandard.new evaluation_standard_params
    if @evaluation_standard.save
      flash[:success] = flash_message "created"
      redirect_to admin_evaluation_standards_path
    else
      flash[:failed] = flash_message "not_created"
      render :new
    end
  end

  def update
    if @evaluation_standard.update_attributes evaluation_standard_params
      flash[:success] = flash_message "updated"
      redirect_to admin_evaluation_standards_path
    else
      render :edit
    end
  end

  def destroy
    if @evaluation_standard.destroy
      flash[:success] = flash_message "deleted"
    else
      flash[:failed] = flash_message "not_deleted"
    end
    redirect_to :back
  end

  private
  def evaluation_standard_params
    params.require(:evaluation_standard).permit EvaluationStandard::ATTRIBUTES_PARAMS
  end

  def find_evaluation_standard
    @evaluation_standard = EvaluationStandard.find_by id: params[:id]
    unless @evaluation_standard
      flash[:alert] = flash_message "not_find"
      redirect_to admin_evaluation_standards_path
    end
  end
end
