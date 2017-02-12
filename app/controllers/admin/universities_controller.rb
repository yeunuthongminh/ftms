class Admin::UniversitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_university, except: [:index, :new, :create]

  def index
    @universities = University.all
  end

  def new
  end

  def create
    @university = University.new university_params
    respond_to do |format|
      if @university.save
        format.html {redirect_to [:admin, @university]}
        format.json do
          render json: {message: flash_message("created"),
            university: @university}
        end
      else
        format.html {render :new}
        format.json do
          render json: {message: flash_message("not_created"),
            errors: @university.errors}, status: :unprocessable_entity
        end
      end
    end
  end

  def show
  end

  def edit
    respond_to do |format|
      format.html
      format.json {render json: {university: @university}}
    end
  end

  def update
    respond_to do |format|
      if @university.update_attributes university_params
        format.html {redirect_to [:admin, @university]}
        format.json do
          render json: {message: flash_message("updated"),
            university: @university}
        end
      else
        format.html {render :edit}
        format.json do
          render json: {message: flash_message("not_updated"),
            errors: @university.errors}, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @university.destroy
    respond_to do |format|
      format.html {redirect_to admin_universities_path}
      format.json do
        if @university.paranoia_destroyed?
          render json: {message: flash_message("deleted")}}
        else
          render json: {message: flash_message("not_deleted")},
            status: :unprocessable_entity
        end
      end
    end
  end

  private
  def university_params
    params.require(:university).permit :name
  end

  def find_university
    @university = University.find_by id: params[:id]
    unless @university
      respond_to do |format|
        format.html {redirect_to admin_universities_path}
        format.json do
          render json: {message: flash_message("not_found")},
            status: :not_found
        end
      end
    end
  end
end
