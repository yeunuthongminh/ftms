class FeedBacksController < ApplicationController
  after_action :verify_authorized

  def create
    @feed_back = current_user.feed_backs.new feed_back_params
    if authorize @feed_back
      if @feed_back.save
        flash.now[:success] = flash_message "created"
      end
      respond_to do |format|
        format.html
        format.js
      end
    else
      redirect_to root_path
    end
  end

  private
  def feed_back_params
    params.require(:feed_back).permit FeedBack::FEED_BACK_ATTRIBUTES_PARAMS
  end
end
