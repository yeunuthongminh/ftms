class Admin::EvaluationItemsController < ApplicationController
  before_action :authorize

  def create
    binding.pry
    params[:items].each do |item|
      evaluation_standard = EvaluationItem.find_by item
      if evaluation_standard.nil?
        @evaluation_item = EvaluationItem.new(
          evaluation_template_id: params[:evaluation_item][:evaluation_template_id],
          evaluation_standard_id: item)
        if @evaluation_item.save
          flash[:success] = flash_message "created"
        else
          flash[:success] = flash_message "not_created"
        end
      else
        flash[:success] = flash_message "not_created"
      end
    end
    redirect_to admin_evaluation_templates_path
  end
end
