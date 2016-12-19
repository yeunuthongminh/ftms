class Admin::EvaluationTemplatesController < ApplicationController
  include FilterData

  before_action :authorize
  before_action :load_filter, only: :index
  before_action :find_evaluation_template, only: [:edit, :update]

  def index
    @evaluation_templates = EvaluationTemplate.all
    @evaluation_templates_presenter = EvaluationTemplatePresenter.new(
      evaluation_templates: @evaluation_templates, namespace: @namespace).render
  end

  def new
    @evaluation_template = EvaluationTemplate.new
    @evaluation_standards = EvaluationStandard.all
  end

  def create
    @evaluation_template = EvaluationTemplate.new evaluation_template_params
    if @evaluation_template.save
      flash[:success] = flash_message "created"
      redirect_to admin_evaluation_templates_path
    else
      flash[:failed] = flash_message "not_created"
      render :new
    end
  end

  def edit
    @evaluation_standards = EvaluationStandard.all - @evaluation_template.evaluation_standards
  end

  def update
    if @evaluation_template.update_attributes evaluation_template_params
      flash[:success] = flash_message "updated"
      redirect_to admin_evaluation_templates_path
    else
      flash[:failed] = flash_message "not_updated"
      render :edit
    end
  end

  private
  def evaluation_template_params
    params.require(:evaluation_template).permit EvaluationTemplate::ATTRIBUTE_PARAMS
  end

  def find_evaluation_template
    @evaluation_template = EvaluationTemplate.find_by id: params[:id]
    unless @evaluation_template
      redirect_to admin_projects_path
      flash[:alert] = flash_message "not_find"
    end
  end
end
