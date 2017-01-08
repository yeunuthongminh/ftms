class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  before_action :load_post, except: [:index, :new, :create]
  before_action :load_supports, only: [:index, :show]
  before_action :authorize_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.search(params[:search])
      .per_page_kaminari(params[:page]).per Settings.per_page if params[:search]
    unless params[:search]
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build post_params
    if @post.save
      flash[:success] = flash_message "created"
      redirect_to @post
    else
      flash.now[:failed] = flash_message "not_created"
      render :new
    end
  end

  def show
    @post.views += 1
    @post.save
    today_post_views = @post.today_post_views
    today_post_views.views += 1
    today_post_views.save
  end

  def update
    if @post.update_attributes post_params
      flash[:success] = flash_message "updated"
      redirect_to @post
    else
      flash.now[:failed] = flash_message "not_updated"
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = flash_message "deleted"
      redirect_to posts_path
    else
      flash[:failed] = flash_message "not_deleted"
      redirect_to @post
    end
  end

  private
  def post_params
    params.require(:post).permit Post::POST_ATTRIBUTES_PARAMS
  end

  def load_post
    @post = Post.includes(:taggings).find_by id: params[:id]
    redirect_if_object_nil @post
  end

  def load_supports
    @supports = Supports::PostSupport.new params: params, post: @post,
      user: current_user
  end

  def authorize_post
    authorize_with_multiple page_params.merge(record: @post), PostPolicy
  end
end
