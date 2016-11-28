class TraineeEvaluation < ApplicationRecord

  ATTRIBUTES_PARAMS = [:trainer_id, :trainee_id, :total_point, :targetable_type,
    :targetable_id, evaluation_check_lists_attributes: [:id, :score, :name,
    :evaluation_standard_id, :_destroy, :use]]

  belongs_to :targetable, polymorphic: true
  belongs_to :trainee, class_name: Trainee.name, foreign_key: :trainee_id
  belongs_to :trainer, class_name: Trainer.name, foreign_key: :trainer_id

  has_many :evaluation_check_lists, dependent: :destroy
  has_many :evaluation_standards, through: :evaluation_check_lists
  has_many :notes, dependent: :destroy

  delegate :name, to: :trainee, prefix: true, allow_nil: true
  delegate :name, to: :trainer, prefix: true, allow_nil: true

  accepts_nested_attributes_for :evaluation_check_lists, allow_destroy: true
end
