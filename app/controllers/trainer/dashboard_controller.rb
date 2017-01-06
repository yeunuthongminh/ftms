class Trainer::DashboardController < ApplicationController
  def index
    @dashboard_support = Supports::Dashboard.new
  end
end
