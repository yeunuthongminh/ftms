class Admin::LocationsController < ApplicationController
  before_action :authorize
  before_action :load_managers, except: [:destroy, :show, :index]
  before_action :find_location, only: [:update, :edit, :destroy, :show]

  def index
    respond_to do |format|
      format.html
      format.json {
        render json: LocationsDatatable.new(view_context, @namespace, current_user)
      }
    end
  end

  def show
    @location_support = Supports::LocationSupport.new location: @location
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new location_params
    respond_to do |format|
      if @location.save
        flash.now[:success] = flash_message "created"
        format.html {redirect_to admin_locations_path}
      else
        flash.now[:failed] = flash_message "not_created"
        format.html {render :new}
      end
      format.js
    end
  end

  def edit
  end

  def update
    if @location.update_attributes location_params
      flash[:success] = flash_message "created"
      redirect_to admin_locations_path
    else
      flash[:failed] = flash_message "not_created"
      render :edit
    end
  end

  def destroy
    if @location.destroy
      flash[:success] = flash_message "deleted"
    else
      flash[:failed] = flash_message "not_deleted"
    end
    redirect_to admin_locations_path
  end

  private
  def location_params
    params.require(:location).permit Location::ATTRIBUTE_PARAMS
  end

  def load_managers
    @managers = User.not_trainees
  end

  def find_location
    @location = Location.includes(:manager).find_by id: params[:id]
    unless @location
      redirect_to admin_locations_path
      flash[:alert] = flash_message "not_find"
    end
  end
end
