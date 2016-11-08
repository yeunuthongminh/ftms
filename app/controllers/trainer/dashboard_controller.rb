class Trainer::DashboardController < ApplicationController
  before_action :check_access, only: :index

  def index
    authorize_with_multiple page_params, Trainer::UserPolicy
    add_breadcrumb_index "dashboard"
    @dashboard_support = Supports::Dashboard.new
  end

  private
  def check_access
    unless current_user.has_role?("trainer")
      flash[:alert] = t "error.not_authorize"
      redirect_to root_path
    end
  end
end
