class Trainer < User
  has_one :location

  has_many :trainees, foreign_key: :trainer_id
  has_many :course_subjects, through: :user_subject
  has_many :user_courses, foreign_key: :user_id
  has_many :courses, through: :user_courses
  has_many :trainer_programs, dependent: :destroy
  has_many :notes, dependent: :destroy
end
