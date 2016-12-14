class Supports::Statistics::StageSupport < Supports::Statistics::ApplicationStatistic
  def stages
    @stage_trainee ||= percentage_trainee_by_in_edu_by_language
  end

  def trainee_in_edu_by_language
    @load_trainee_by_location_and_type ||= Profile.where(user_id: load_all_trainee,
      location_id: @location_ids, trainee_type_id: @trainee_type_ids, stage_id: 3)
      .includes :language

    @load_trainee = trainee_by_statistic @load_trainee_by_location_and_type, "language"
  end

  def presenters
    StatisticStagePresenter.new(trainee_in_edu_by_language).render
  end

  def percentage_trainee_by_in_edu_by_language
    list_languages = trainee_in_edu_by_language
    total_trainee = list_languages.sum {|u| u[:y]}

    other_language = Hash[:name, I18n.t("statistics.other"), :y, 0]
    languages = Array.new

    list_languages.each do |language|
      percent = language[:y].to_f / total_trainee.to_f * 100
      languages << language
        .merge(extraValue: ActionController::Base.helpers
          .number_to_percentage(percent))
    end
    languages
  end
end
