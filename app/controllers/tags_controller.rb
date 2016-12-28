class TagsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def index
    @tags = Tag.per_page_kaminari(params[:page]).per Settings.tags_per_page
  end

  def show
    @posts = if params[:id]
      Post.tagged_with params[:id]
    else
      Array.new
    end
  end
end
