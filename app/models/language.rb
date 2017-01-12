class Language < ApplicationRecord
  acts_as_paranoid

  ATTRIBUTES_PARAMS = [:name]

  has_many :profiles
  has_many :categories
  has_many :courses
  has_many :statistics, dependent: :destroy

  validates :name, presence: true

  scope :order_by_trainee, -> do
    left_outer_joins(:profiles).group(:id).order "COUNT(profiles.id) DESC"
  end
end
