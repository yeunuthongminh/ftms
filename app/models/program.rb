class Program < ApplicationRecord
  acts_as_paranoid

  has_closure_tree

  ATTRIBUTES_PARAMS = [:name, trainer_programs_attributes: [:id, :user_id,
    :_destroy, :deleted_at]]

  has_many :trainer_programs, -> {with_deleted}, dependent: :destroy
  has_many :users, through: :trainer_programs
  has_many :courses, dependent: :destroy

  enum program_type: ["open_education", "internal_education", "university"]

  accepts_nested_attributes_for :trainer_programs, allow_destroy: true
end
