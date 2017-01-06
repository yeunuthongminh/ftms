class Trainer::FeedBacksController < ApplicationController
  before_action :authorize, only: :index

  def index
    @feed_backs = FeedBack.includes(:user).order_desc :created_at
  end
end
