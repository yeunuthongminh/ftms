class TrainerCourse < UserCourse
  include StiRouting

  alias_attribute :trainer, :user

  has_many :user_subjects, dependent: :destroy
end
