class Trainer < User
  include StiRouting
  has_one :location

  has_many :user_courses, foreign_key: :user_id
  has_many :courses, through: :user_courses
  has_many :trainer_programs, dependent: :destroy
  has_many :trainee_evaluations, class_name: TraineeEvaluation.name,
    foreign_key: :trainer_id
  has_many :trainer_evaluations, through: :trainee_evaluations,
    source: :trainer
end
