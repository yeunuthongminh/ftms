class Filter < ApplicationRecord
  belongs_to :user

  enum filter_type: [:training_managements, :courses, :exams, :total_trainees]
end
