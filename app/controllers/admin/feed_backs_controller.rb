class Admin::FeedBacksController < ApplicationController
  before_action :authorize, only: :index

  def index
    @feed_backs = FeedBack.all
    @feed_backs = @feed_backs.includes(:user).order_desc :created_at
  end
end
