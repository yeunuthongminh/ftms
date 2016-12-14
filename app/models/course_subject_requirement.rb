class CourseSubjectRequirement < ApplicationRecord
  belongs_to :course_subject
  belongs_to :project_requirement
end
