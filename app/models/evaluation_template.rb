class EvaluationTemplate < ApplicationRecord
  acts_as_paranoid

  has_many :evaluation_items, dependent: :destroy
  has_many :evaluation_standards, through: :evaluation_items

  ATTRIBUTE_PARAMS = [:name, evaluation_standard_ids: []]
end
