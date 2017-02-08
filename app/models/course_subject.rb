class CourseSubject < ApplicationRecord
  acts_as_paranoid

  belongs_to :subject
  belongs_to :course

  has_many :user_subjects, dependent: :destroy
  has_many :course_subject_teams, dependent: :destroy
end
