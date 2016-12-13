class EvaluationStandard < ApplicationRecord
  acts_as_paranoid

  ATTRIBUTES_PARAMS = [:name, :min_point, :max_point]

  has_many :evaluation_check_lists
  has_many :trainee_evaluations, through: :evaluation_check_lists
  has_many :evaluation_templates, through: :evaluation_items

  scope :not_yet, ->evaluation_template_id {where "id not in (select
    evaluation_standard_id from evaluation_items
    where evaluation_template_id = ?)", evaluation_template_id}
end
