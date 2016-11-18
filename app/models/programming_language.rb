class ProgrammingLanguage < ApplicationRecord
  acts_as_paranoid

  ATTRIBUTES_PARAMS = [:name]

  has_many :profiles
  has_many :courses
  has_many :statistics, dependent: :destroy

  validates :name, presence: true
end
