class Trainer::FeedBacksController < ApplicationController
  before_action :authorize, only: :index

  def index
    @feed_backs = FeedBack.order_by_time
    add_breadcrumb_index "feed_backs"
  end
end
