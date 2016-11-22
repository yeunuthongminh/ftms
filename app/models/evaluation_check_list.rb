class EvaluationCheckList < ApplicationRecord
  belongs_to :trainee_evaluation
  belongs_to :evaluation_standard

  delegate :name, to: :evaluation_standard, prefix: true, allow_nil: true
end
