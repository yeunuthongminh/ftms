class Comment < ApplicationRecord
  acts_as_paranoid
  acts_as_votable

  has_closure_tree dependent: :destroy

  belongs_to :user
  belongs_to :post

  has_many :likes, dependent: :destroy, as: :likeable
  delegate :name, to: :user, prefix: true, allow_nil: true
end
