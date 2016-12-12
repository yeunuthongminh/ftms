class Supports::Statistics::LanguageSupport < Supports::Statistics::ApplicationStatistic
  def languages
    @languages ||= load_languages.includes(:profiles)
      .collect {|u| Hash[:name, u.name, :y, u.profiles.size]}
      .sort_by {|u| u[:y]}.reverse
  end

  def trainee_by_language
    @load_all_trainee_by_language ||= Language.includes(:profiles)
      .collect{|u| Hash[:name, u.name, :y, u.profiles.size]}
      .sort_by {|u| u[:y]}.reverse
  end

  def presenters
    StatisticLanguagePresenter.new(trainee_by_language).render
  end
end
