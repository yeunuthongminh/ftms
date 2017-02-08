class UserSubject < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :user_course
  belongs_to :course_subject
  belongs_to :subject

  has_many :properties, as: :objectable, dependent: :destroy
end
