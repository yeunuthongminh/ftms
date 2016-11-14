class EvaluationCheckList < ApplicationRecord
  acts_as_paranoid

  belongs_to :trainee_evaluation
  belongs_to :evaluation_criteria
end
