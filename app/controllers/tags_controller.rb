class TagsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def show
    @posts = if params[:id]
      Post.tagged_with params[:id]
    else
      Array.new
    end
  end
end
