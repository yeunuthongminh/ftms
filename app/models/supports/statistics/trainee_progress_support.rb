class Supports::Statistics::TraineeProgressSupport < Supports::Statistics::ApplicationStatistic

  def presenters
    TraineeProgressPresenter.new(trainee_by_course).render
  end

  private
  def trainee_by_course
    @load_all_trainee_by_course ||= Trainee.includes(profile: [:trainee_type,
      :location, :status], user_courses: [:course, user_subjects: :course_subject])
  end
end
