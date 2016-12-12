class Supports::Statistics::TraineeProgressSupport < Supports::Statistics::ApplicationStatistic

  def presenters
    TraineeProgressPresenter.new(trainee_by_course).render
  end

  private
  def trainee_by_course
    @load_all_trainee_by_course ||= Trainee.all
  end

end
