class Exam < ApplicationRecord
  acts_as_paranoid

  belongs_to :user_subject

  has_many :results, dependent: :destroy
  has_many :questions, through: :results

  accepts_nested_attributes_for :results, allow_destroy: true
end
