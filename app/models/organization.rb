class Organization < ApplicationRecord
  acts_as_paranoid

  belongs_to :user

  has_many :profiles, dependent: :destroy
  has_many :programs, dependent: :destroy
end
