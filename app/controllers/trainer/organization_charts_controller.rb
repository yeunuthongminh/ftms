class Trainer::OrganizationChartsController < ApplicationController
  def index
    @locations = Location.includes :manager
  end
end
