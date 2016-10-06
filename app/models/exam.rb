class Exam < ApplicationRecord
  acts_as_paranoid

  EXAM_ATTRIBUTES_PARAMS = [:user_subject_id, results_attributes: [:id, :questions_id, :answer_id]]

  belongs_to :user_subject

  has_many :results, dependent: :destroy
  has_many :questions, through: :results

  accepts_nested_attributes_for :results, allow_destroy: true
end
