class PostsController < ApplicationController
  def index
    @supports = Supports::PostSupport.new params: params
  end
end
