class TraineeType < ApplicationRecord
  acts_as_paranoid

  ATTRIBUTES_PARAMS = [:name, :color]

  has_many :profiles
  has_many :statistics, dependent: :destroy

  validates :name, presence: true
end
