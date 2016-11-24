class TraineeEvaluation < ApplicationRecord

  ATTRIBUTES_PARAMS = [:trainer_id, :trainee_id, :total_point, :targetable_type,
    :targetable_id, evaluation_check_lists_attributes: [:id, :score,
    :evaluation_standard_id, :_destroy], notes_attributes: [:id, :name,
    :trainee_evaluation_id, :_destroy]]

  belongs_to :targetable, polymorphic: true
  belongs_to :trainee, class_name: Trainee.name, foreign_key: :trainee_id
  belongs_to :trainer, class_name: Trainer.name, foreign_key: :trainer_id

  has_many :evaluation_check_lists, dependent: :destroy
  has_many :evaluation_standards, through: :evaluation_check_lists
  has_many :notes, dependent: :destroy

  accepts_nested_attributes_for :evaluation_check_lists, allow_destroy: true
  accepts_nested_attributes_for :notes, allow_destroy: true,
    reject_if: proc {|attributes| attributes[:name].blank?}
end
