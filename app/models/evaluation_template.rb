class EvaluationTemplate < ApplicationRecord
  acts_as_paranoid

  belongs_to :training_standard

  has_many :evaluation_standards, dependent: :destroy
end
