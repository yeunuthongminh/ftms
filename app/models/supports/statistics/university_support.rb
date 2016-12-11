class Supports::Statistics::UniversitySupport < Supports::Statistics::ApplicationStatistic
  def universities
    @universities ||= percentage_trainee_by_university
  end

  def presenters
    StatisticUniversityPresenter.new(trainee_by_university).render
  end

  def trainee_by_university
    @load_trainee_by_location_and_type ||= Profile.where(user_id: load_all_trainee,
      location_id: @location_ids, trainee_type_id: @trainee_type_ids)
      .includes :university

    unless @load_all_trainee_by_university
      none_university = Hash[:name, I18n.t("statistics.none"), :y, 0]
      all_universities = University.all.map do |u|
        Hash[:name, u[:abbreviation], :y, 0, :full_name, u[:name]]
      end
      @load_trainee_by_location_and_type.each do |trainee|
        if trainee.university
          found_university = all_universities.find do |u|
            u[:name] == trainee.university_abbreviation
          end
          found_university[:y] += 1
        else
          none_university[:y] += 1
        end
      end
      all_universities << none_university
      @load_all_trainee_by_university = all_universities.sort_by {|u| u[:y]}
        .reverse
    end
    @load_all_trainee_by_university
  end

  def percentage_trainee_by_university
    list_universities = trainee_by_university
    total_trainee = list_universities.sum {|u| u[:y]}

    other_university = Hash[:name, I18n.t("statistics.other"), :y, 0]
    universities = Array.new

    list_universities.each do |university|
      percent = university[:y].to_f / total_trainee.to_f * 100
      if percent <= Settings.minimum_percent_to_join
        other_university[:y] += university[:y]
      else
        university.delete :full_name
        universities << university
          .merge(extraValue: ActionController::Base.helpers
            .number_to_percentage(percent))
      end
    end
    if other_university[:y] > 0
      universities << other_university
        .merge(extraValue: ActionController::Base.helpers
          .number_to_percentage(other_university[:y].to_f / total_trainee
            .to_f * 100))
    end
    universities
  end
end
