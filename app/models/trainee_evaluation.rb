class TraineeEvaluation < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :targetable, polymophic: true

  has_many :evaluation_check_lists, dependent: :destroy
  has_many :evaluation_criterias, through: :evaluation_check_lists
end
