class Exam < ApplicationRecord
  acts_as_paranoid

  EXAM_ATTRIBUTES_PARAMS = [:user_subject_id, :status, :spent_time,
    results_attributes: [:id, :questions_id, :answer_id]]

  belongs_to :user
  belongs_to :user_subject
  belongs_to :category

  has_many :results, dependent: :destroy
  has_many :questions, through: :results

  scope :finished, ->{where status: :finish}
  scope :not_finished, ->{where.not status: :finish}

  accepts_nested_attributes_for :results, allow_destroy: true

  enum status: [:init, :testing, :finish]

  delegate :name, to: :user, prefix: true, allow_nil: true
end
