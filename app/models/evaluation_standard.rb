class EvaluationStandard < ApplicationRecord
  acts_as_paranoid

  ATTRIBUTES_PARAMS = [:name, :min_point, :max_point, :avarage]

  has_many :evaluation_check_lists
  has_many :trainee_evaluations, through: :evaluation_check_lists
  has_many :evaluation_items, dependent: :destroy
  has_many :evaluation_templates, through: :evaluation_items
end
