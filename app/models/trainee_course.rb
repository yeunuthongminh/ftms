class TraineeCourse < UserCourse
  include StiRouting
  include InitUserSubject

  alias_attribute :trainee, :user

  has_many :user_subjects, ->{with_deleted}, foreign_key: :user_course_id, dependent: :destroy

  delegate :name, to: :trainee, prefix: true, allow_nil: true
end
