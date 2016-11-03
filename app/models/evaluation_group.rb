class EvaluationGroup < ApplicationRecord
  acts_as_paranoid

  has_many :evaluation_items, dependent: :destroy
end
