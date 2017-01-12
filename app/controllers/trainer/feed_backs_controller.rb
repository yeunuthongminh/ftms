class Trainer::FeedBacksController < ApplicationController
  before_action :authorize, only: :index

  def index
    @feed_backs = FeedBack.includes(:user).order_desc :created_at
    add_breadcrumb_index "feed_backs"
  end
end
