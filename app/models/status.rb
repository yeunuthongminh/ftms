class Status < ApplicationRecord
  acts_as_paranoid

  ATTRIBUTES_PARAMS = [:name, :color]

  has_many :profiles

  validates :name, presence: true
  validates :color, presence: true
end
