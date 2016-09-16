class Notification < ApplicationRecord
  belongs_to :user

  belongs_to :trackable, polymorphic: true

  has_many :user_notifications, dependent: :destroy

  enum key: [:start, :finish, :reopen, :request, :reject]
end
