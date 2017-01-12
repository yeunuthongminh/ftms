class Trainer::DashboardController < ApplicationController
  def index
    add_breadcrumb_index "dashboard"
    @dashboard_support = Supports::Dashboard.new
  end
end
