class Trainee < User
  include StiRouting
  belongs_to :trainer

  has_one :evaluation, dependent: :destroy

  has_many :exams, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  has_many :course_subjects, through: :user_subject
  has_many :user_courses, foreign_key: :user_id
  has_many :courses, through: :user_courses
  has_many :user_tasks, dependent: :destroy
  has_many :tasks, through: :user_tasks
end
