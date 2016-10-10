class Exam < ApplicationRecord
  acts_as_paranoid

  EXAM_ATTRIBUTES_PARAMS = [:user_subject_id, :status, :spent_time,
    results_attributes: [:id, :questions_id, :answer_id]]

  belongs_to :user
  belongs_to :user_subject

  has_many :results, dependent: :destroy
  has_many :questions, through: :results

  accepts_nested_attributes_for :results, allow_destroy: true

  enum status: [:init, :testing, :finish]

  def remaining_time
    init? || testing? ? duration.minutes - (Time.zone.now - started_at).to_i : 0
  end
end
