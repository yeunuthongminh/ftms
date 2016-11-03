class Program < ApplicationRecord
  acts_as_paranoid

  has_many :trainer_programs, dependent: :destroy
  has_many :users, through: :trainer_programs
  has_many :courses, dependent: :destroy
end
