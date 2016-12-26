class UserNotification < ApplicationRecord
  include OrderScope

  acts_as_paranoid

  belongs_to :notification
  belongs_to :user
end
