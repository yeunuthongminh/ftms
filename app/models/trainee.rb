class Trainee < User
  include StiRouting
  belongs_to :trainer

  has_many :trainee_evaluations, class_name: TraineeEvaluation.name,
    foreign_key: :trainee_id
  has_many :trainees_evaluations, through: :trainee_evaluations,
    source: :trainee

  has_many :exams, dependent: :destroy, foreign_key: :user_id
  has_many :user_subjects, dependent: :destroy, foreign_key: :user_id
  has_many :course_subjects, through: :user_subject
  has_many :user_courses, foreign_key: :user_id
  has_many :courses, through: :user_courses
  has_many :user_tasks, dependent: :destroy, foreign_key: :user_id
  has_many :tasks, through: :user_tasks
  has_many :notes, dependent: :destroy, foreign_key: :user_id
end
