class Filter < ApplicationRecord
  belongs_to :user

  enum filter_type: [:training_managements, :courses, :exams, :statistics,
    :questions, :trainee_evaluations]
end
