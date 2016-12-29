class UserNotification < ApplicationRecord
  include OrderScope

  acts_as_paranoid

  belongs_to :notification
  belongs_to :user

  scope :not_seen, -> {where seen: false}
  scope :order_by_time, -> {order created_at: :desc}
end
