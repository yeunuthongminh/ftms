class Result < ApplicationRecord
  acts_as_paranoid

  belongs_to :question
  belongs_to :answer
  belongs_to :test
end
