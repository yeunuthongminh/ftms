class Supports::Statistics::LocationSupport < Supports::Statistics::ApplicationStatistic
  def trainee_by_locations
    @trainee_by_locations ||= Hash[load_locations
      .collect{|l| [l.name, l.profiles.size]}]
  end

  def trainee_by_location
    @load_all_trainee_by_language ||= Location.includes(:profiles)
      .collect{|u| Hash[:name, u.name, :y, u.profiles.size]}
      .sort_by {|u| u[:y]}.reverse
  end

  def presenters
    StatisticLocationPresenter.new(trainee_by_location).render
  end
end
