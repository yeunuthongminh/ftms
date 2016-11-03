class Program < ApplicationRecord
  acts_as_paranoid

  ATTRIBUTES_PARAMS = [:name, trainer_programs_attributes: [:id, :user_id,
    :_destroy, :deleted_at]]

  has_many :trainer_programs, -> {with_deleted}, dependent: :destroy
  has_many :users, through: :trainer_programs
  has_many :courses, dependent: :destroy

  accepts_nested_attributes_for :trainer_programs, allow_destroy: true
end
