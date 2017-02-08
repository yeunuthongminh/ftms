class UserCourse < ApplicationRecord
  require_dependency "course_manager"
  require_dependency "course_member"

  acts_as_paranoid

  belongs_to :user
  belongs_to :course

  has_many :user_subjects, dependent: :destroy
end
