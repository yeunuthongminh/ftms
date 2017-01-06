class Admin::OrganizationChartsController < ApplicationController
  before_action :authorize

  def index
    @locations = Location.includes :manager
  end
end
