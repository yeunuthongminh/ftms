class University < ApplicationRecord
  acts_as_paranoid

  ATTRIBUTES_PARAMS = [:name, :abbreviation]

  has_many :profiles

  validates :name, presence: true
end
