class EvaluationCriteria < ApplicationRecord
  acts_as_paranoid

  has_many :evaluation_check_lists
  has_many :trainee_evaluations, through: :evaluation_check_lists
  has_many :evaluation_items
end
