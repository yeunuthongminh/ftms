class TrainerCourse < UserCourse
  include StiRouting

  alias_attribute :trainer, :user
end
