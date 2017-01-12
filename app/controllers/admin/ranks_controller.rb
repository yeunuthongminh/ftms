class Admin::RanksController < ApplicationController
  before_action :authorize
  before_action :load_rank, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html {add_breadcrumb_index "ranks"}
      format.json {
        render json: RanksDatatable.new(view_context, @namespace)
      }
    end
  end

  def new
    @rank = Rank.new
    add_breadcrumb_path "ranks"
    add_breadcrumb_new "ranks"
  end

  def create
    @rank = Rank.new rank_params
    if @rank.save
      flash[:success] = flash_message "created"
      redirect_to admin_ranks_path
    else
      flash[:failed] = flash_message "not_created"
      render :new
    end
  end

  def edit
    add_breadcrumb_path "ranks"
    add_breadcrumb @rank.rank_value
    add_breadcrumb_edit "ranks"
  end

  def update
    if @rank.update_attributes rank_params
      flash[:success] = flash_message "updated"
      redirect_to admin_ranks_path
    else
      flash_message[:failed] = flash_message "not_updated"
      render :edit
    end
  end

  def destroy
    if @rank.destroy
      flash[:success] = flash_message "deleted"
    else
      flash[:failed] = flash_message "not_deleted"
    end
    redirect_to :back
  end

  private
  def rank_params
    params.require(:rank).permit Rank::ATTRIBUTES_PARAMS
  end

  def load_rank
    @rank = Rank.find_by id: params[:id]
    unless @rank
      redirect_to admin_ranks_path
      flash[:alert] = flash_message "not_find"
    end
  end
end
