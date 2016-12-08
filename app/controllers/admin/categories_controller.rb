class Admin::CategoriesController < ApplicationController
  include FilterData

  before_action :authorize
  before_action :load_category, only: [:edit, :update, :destroy]
  before_action :load_supports, only: :edit

  def index
    respond_to do |format|
      format.html {add_breadcrumb_index "categories"}
      format.json do
        render json: CategoriesDatatable.new(view_context, @namespace, current_user)
      end
    end
  end

  def new
    @category = Category.new
    @supports = Supports::CategorySupport.new category: @category

    respond_to do |format|
      format.js
    end
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = flash_message "created"
    else
      flash[:failed] = flash_message "not_created"
    end

    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = flash_message "updated"
    else
      flash[:failed] = flash_message "not_updated"
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = flash_message "deleted"
    else
      flash[:failed] = flash_message "not_deleted"
    end

    respond_to do |format|
      format.js
    end
  end

  private
  def category_params
    params.require(:category).permit Category::ATTRIBUTES_PARAMS
  end

  def load_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:alert] = flash_message "not_find"
      respond_to do |format|
        format.html {redirect_to admin_categories_path}
        format.js
      end
    end
  end

  def load_supports
    @supports = Supports::CategorySupport.new category: @category
  end
end
