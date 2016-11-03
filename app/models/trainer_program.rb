class TrainerProgram < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :program
end
