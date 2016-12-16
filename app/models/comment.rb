class Comment < ApplicationRecord
  acts_as_paranoid
  acts_as_votable

  has_closure_tree

  belongs_to :user
  belongs_to :post
end
