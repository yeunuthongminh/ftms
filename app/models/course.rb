class Course < ApplicationRecord
  acts_as_paranoid

  belongs_to :language
  belongs_to :program
  belongs_to :training_standard

  has_many :user_courses, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
  has_many :user_subjects, through: :course_subjects
  has_many :subjects, through: :course_subjects, dependent: :destroy
  has_many :sources, as: :sourceable,
    class_name: MovingHistory.name, dependent: :destroy
  has_many :destinations, as: :destinationable,
    class_name: MovingHistory.name, dependent: :destroy
  has_many :static_properties, as: :ownerable, dependent: :destroy
end
