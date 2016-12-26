class Category < ApplicationRecord
  acts_as_paranoid

  ATTRIBUTES_PARAMS = [:name, :language_id]

  belongs_to :language

  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :subject_categories, dependent: :destroy
  has_many :subjects, through: :subject_categories

  delegate :name, to: :language, prefix: true, allow_nil: true
end
