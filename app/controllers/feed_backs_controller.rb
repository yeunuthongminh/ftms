class FeedBacksController < ApplicationController
  def create
    @feed_back = current_user.feed_backs.new feed_back_params
    authorize_with_multiple page_params.merge(record: @feed_back), FeedBackPolicy
    if @feed_back.save
      flash.now[:success] = flash_message "created"
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def feed_back_params
    params.require(:feed_back).permit FeedBack::FEED_BACK_ATTRIBUTES_PARAMS
  end
end
