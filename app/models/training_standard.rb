class TrainingStandard < ApplicationRecord
  acts_as_paranoid

  belongs_to :program

  has_one :evaluation_template, dependent: :destroy

  has_many :courses, dependent: :destroy
  has_many :subjects, dependent: :destroy
end
