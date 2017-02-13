class Organization < ApplicationRecord
  acts_as_paranoid

  belongs_to :owner, class_name: User.name, foreign_key: :user_id

  has_many :profiles, dependent: :destroy
  has_many :users, through: :profiles
  has_many :programs, dependent: :destroy
end
