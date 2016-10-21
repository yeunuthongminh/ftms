class Admin::StatisticsController < ApplicationController
  load_and_authorize_resource class: false
  skip_load_resource only: :create
  before_action :load_locations

  def index
    add_breadcrumb_index "statistics"
    @statistics = Supports::Statistic.new
  end

  def create
    locations = @locations.where id: params[:location_ids]
    @statistics = Supports::Statistic.new locations: locations
    respond_to do |format|
      format.js
    end
  end

  private
  def load_locations
    @locations = Location.includes profiles: :user_type
  end
end
