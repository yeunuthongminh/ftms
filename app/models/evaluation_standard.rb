class EvaluationStandard < ApplicationRecord
  acts_as_paranoid

  belongs_to :evaluation_template
end
