class Supports::Statistics::LanguageSupport < Supports::Statistics::ApplicationStatistic
  def languages
    @languages ||= load_languages.includes(:profiles)
      .collect {|u| Hash[:name, u.name, :y, u.profiles.size]}
      .sort_by {|u| u[:y]}.reverse
  end
end
