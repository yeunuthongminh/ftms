class UserNotification < ApplicationRecord
  acts_as_paranoid

  belongs_to :notification
  belongs_to :user
end
