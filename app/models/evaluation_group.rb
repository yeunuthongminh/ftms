class EvaluationGroup < ApplicationRecord
  acts_as_paranoid

  has_many :evaluation_items, dependent: :destroy
  has_many :evaluation_standards, through: :evaluation_items

  accepts_nested_attributes_for :evaluation_standards, allow_destroy: true
end
