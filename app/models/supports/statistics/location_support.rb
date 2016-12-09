class Supports::Statistics::LocationSupport < Supports::Statistics::ApplicationStatistic
  def trainee_by_locations
    @trainee_by_locations ||= Hash[load_locations
      .collect{|l| [l.name, l.profiles.size]}]
  end
end
