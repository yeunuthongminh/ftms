class Program < ApplicationRecord
  acts_as_paranoid

  belongs_to :organization

  has_many :courses, dependent: :destroy
  has_many :profiles, dependent: :destroy
  has_many :training_standards, dependent: :destroy
  has_many :user_programs, dependent: :destroy
  has_many :sources, as: :sourceable,
    class_name: MovingHistory.name, dependent: :destroy
  has_many :destinations, as: :destinationable,
    class_name: MovingHistory.name, dependent: :destroy
end
