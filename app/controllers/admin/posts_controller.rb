class Admin::PostsController < ApplicationController
  include FilterData
  before_action :authorize
  before_action :load_post, except: :index
  before_action :load_supports, only: :index

  def index
    add_breadcrumb_index "posts"
  end

  def show
    add_breadcrumb_path "posts"
    add_breadcrumb @post.title, :admin_post_path
  end

  def destroy
    if @post.destroy
      flash[:success] = flash_message "deleted"
      redirect_to admin_posts_path
    else
      flash[:failed] = flash_message "not_deleted"
      redirect_to admin_post_path @post
    end
  end

  private
  def load_supports
    @supports = Supports::PostSupport.new params: params, post: @post,
      filter_service: load_filter
  end

  def load_post
    @post = Post.find_by id: params[:id]
    redirect_if_object_nil @post
  end
end
