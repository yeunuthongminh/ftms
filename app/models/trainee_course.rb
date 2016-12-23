class TraineeCourse < UserCourse
  include StiRouting

  alias_attribute :trainee, :user

  has_many :user_subjects, ->{with_deleted}, foreign_key: :user_course_id, dependent: :destroy

  after_create :init_user_subjects

  private
  def init_user_subjects
    create_user_subjects [self], course.course_subjects, course_id
  end
end
