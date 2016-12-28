class LikesController < ApplicationController
  before_action :check_likeable, only: [:create, :destroy]

  def create
    @like = @likeable.likes.build user: current_user
    @like.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @like = @likeable.likes.find_by user: current_user
    @like.destroy if @like
    respond_to do |format|
      format.js
    end
  end

  private
  def check_likeable
    model = [Post, Comment].detect {|object| params["#{object.name.underscore}_id"]}
    @likeable = model.find params["#{model.name.underscore}_id"] if model
    unless @likeable
      flash[:danger] = t "faq.like.find_likeable_fail"
      redirect_to root_path
    end
  end
end
