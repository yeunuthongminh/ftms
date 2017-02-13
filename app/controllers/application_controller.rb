class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Pundit
  include Authorize

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception
end
