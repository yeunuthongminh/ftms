class Admin < User
  include StiRouting
  has_many :user_courses, foreign_key: :user_id
  has_many :courses, through: :user_courses
end
