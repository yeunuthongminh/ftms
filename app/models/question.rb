class Question < ApplicationRecord
  acts_as_paranoid

  belongs_to :subject

  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :exams, through: :results

  scope :random, ->count, level{where(level: level).order("RAND()").limit(count)}

  accepts_nested_attributes_for :answers, allow_destroy: true

  enum level: [:easy, :normal, :hard]
end
