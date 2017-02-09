class CourseSubjectTeam < ApplicationRecord
  acts_as_paranoid

  belongs_to :team
  belongs_to :course_subject
end
