class Post < ApplicationRecord
  acts_as_paranoid
  acts_as_taggable
  acts_as_votable

  belongs_to :user

  has_many :comments

  scope :most_viewed, ->{order views: :desc}
end
