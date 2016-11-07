class Trainee < User
  belongs_to :trainer, foreign_key: :trainer_id

  has_one :evaluation, dependent: :destroy

  has_many :exams, dependent: :destroy
  has_many :user_subjects, foreign_key: :user_id
  has_many :course_subjects, through: :user_subject
  has_many :user_courses, foreign_key: :user_id
  has_many :courses, through: :user_courses
  has_many :user_tasks, dependent: :destroy, foreign_key: :user_id
  has_many :tasks, through: :user_tasks
end
