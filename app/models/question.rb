class Question < ApplicationRecord
  acts_as_paranoid

  belongs_to :subject

  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :tests, through: :results
end
