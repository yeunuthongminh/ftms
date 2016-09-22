class Trainer::OrganizationChartsController < ApplicationController
  before_action :verify_trainer

  def index
    @locations = Location.includes :manager

    add_breadcrumb_index "organization_charts"
  end

  private
  include VerifyTrainer
end
