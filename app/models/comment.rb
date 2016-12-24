class Comment < ApplicationRecord
  acts_as_paranoid
  acts_as_votable

  has_closure_tree dependent: :destroy

  belongs_to :user
  belongs_to :post

  delegate :name, to: :user, prefix: true, allow_nil: true

  scope :order_by_votes, ->{order cached_votes_score: :desc}
end
