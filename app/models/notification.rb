class Notification < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :trackable, polymorphic: true

  has_many :user_notifications, dependent: :destroy

  delegate :name, to: :user, prefix: true, allow_nil: true

  enum key: [:change_status_up, :change_status_down, :finish_course, :start_course, :assign_project]
end
