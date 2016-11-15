class TraineeEvaluation < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :targetable, polymorphic: true

  has_many :evaluation_check_lists, dependent: :destroy
  has_many :evaluation_standards, through: :evaluation_check_lists
end
