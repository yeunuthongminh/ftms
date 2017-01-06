class Admin::DashboardController < ApplicationController

  def index
    authorize_with_multiple page_params, Admin::UserFunctionPolicy
    @dashboard_support = Supports::Dashboard.new
  end
end
