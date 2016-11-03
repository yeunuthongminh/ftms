class EvaluationItem < ApplicationRecord
  acts_as_paranoid

  belongs_to :evaluation_criteria
  belongs_to :evaluation_group
end
