class Admin::DashboardController < ApplicationController
  authorize_resource class: false

  def index
    add_breadcrumb_index "dashboard"
    @dashboard_support = Supports::Dashboard.new
  end
end
