class Category < ApplicationRecord
  acts_as_paranoid

  belongs_to :language

  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :subject_categories, dependent: :destroy
  has_many :subjects, through: :subject_categories
end
