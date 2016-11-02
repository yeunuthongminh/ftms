class Admin::StatisticsController < ApplicationController
  before_action :authorize
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
