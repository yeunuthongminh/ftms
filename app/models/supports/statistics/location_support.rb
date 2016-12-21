class Supports::Statistics::LocationSupport < Supports::Statistics::ApplicationStatistic
  def initialize args = {}
    @locations ||= Location.includes :profiles
  end

  def trainee_by_locations
    @trainee_by_locations ||= Hash[@locations
      .collect{|l| [l.name, l.profiles.size]}]
  end

  def presenters
    StatisticLocationPresenter.new(trainee_by_locations).render
  end
end
