class Trainer::OrganizationChartsController < ApplicationController
  def index
    @locations = Location.includes :manager

    add_breadcrumb_index "organization_charts"
  end
end
