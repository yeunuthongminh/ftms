class FeedBack < ApplicationRecord
  include OrderScope

  acts_as_paranoid

  FEED_BACK_ATTRIBUTES_PARAMS = [:content]

  belongs_to :user

  validates :content, presence: true

  delegate :name, to: :user, prefix: true, allow_nil: true
end
