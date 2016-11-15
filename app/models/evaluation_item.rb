class EvaluationItem < ApplicationRecord
  acts_as_paranoid

  belongs_to :evaluation_standard
  belongs_to :evaluation_group
end
