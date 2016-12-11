class Supports::Statistics::LanguageSupport < Supports::Statistics::ApplicationStatistic
  def languages
    @languages ||= percentage_trainee_by_language
  end

  def trainee_by_language
    @load_trainee_by_location_and_type ||= Profile.where(user_id: load_all_trainee,
      location_id: @location_ids, trainee_type_id: @trainee_type_ids)
      .includes :language

    unless @load_all_trainee_by_language
      none_language = Hash[:name, I18n.t("statistics.none"), :y, 0]
      all_languages = Language.all.map do |u|
        Hash[:name, u[:name], :y, 0]
      end
      @load_trainee_by_location_and_type.each do |trainee|
        if trainee.language
          found_language = all_languages.find do |u|
            u[:name] == trainee.language.name
          end
          found_language[:y] += 1
        else
          none_language[:y] += 1
        end
      end
      all_languages << none_language
      @load_all_trainee_by_language = all_languages.sort_by {|u| u[:y]}
        .reverse
    end
    @load_all_trainee_by_language
  end

  def presenters
    StatisticLanguagePresenter.new(trainee_by_language).render
  end

  def percentage_trainee_by_language
    list_languages = trainee_by_language
    total_trainee = list_languages.sum {|u| u[:y]}

    other_language = Hash[:name, I18n.t("statistics.other"), :y, 0]
    languages = Array.new

    list_languages.each do |language|
      percent = language[:y].to_f / total_trainee.to_f * 100
      if percent <= Settings.minimum_percent_to_join
        other_language[:y] += language[:y]
      else
        languages << language
          .merge(extraValue: ActionController::Base.helpers
            .number_to_percentage(percent))
      end
    end
    if other_language[:y] > 0
      languages << other_language
        .merge(extraValue: ActionController::Base.helpers
          .number_to_percentage(other_language[:y].to_f / total_trainee
            .to_f * 100))
    end
    languages
  end
end
