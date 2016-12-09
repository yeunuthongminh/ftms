class Supports::Statistics::UniversitySupport < Supports::Statistics::ApplicationStatistic
  def universities
    @universities ||= percentage_trainee_by_university
  end

  def university_presenters
    StatisticUniversityPresenter.new(trainee_by_university).render
  end

  def trainee_by_university
    @load_trainee_by_location_and_type ||= Profile.where(location_id:
      @location_ids, trainee_type_id: @trainee_type_ids)
      .includes :university

    @other_university ||= Hash[:name, I18n.t("statistics.other"), :y, 0]

    unless @load_all_trainee_by_university
      all_universities = Array.new
      @load_trainee_by_location_and_type.each do |trainee|
        if trainee.university
          found_university = all_universities.find do |u|
            u[:name] == trainee.university_abbreviation
          end
          if found_university
            found_university[:y] += 1
          else
            all_universities << Hash[:name, trainee.university_abbreviation,
              :y, 1, :full_name, trainee.university_name]
          end
        else
          @other_university[:y] += 1
        end
      end
      all_universities << @other_university
      @load_all_trainee_by_university = all_universities.sort_by {|u| u[:y]}
        .reverse
    end
    @load_all_trainee_by_university
  end

  def percentage_trainee_by_university
    list_universities = trainee_by_university
    total_trainee = list_universities.sum {|u| u[:y]}
    list_universities -= [@other_university]

    other_university = Hash[:name, @other_university[:name], :y,
      @other_university[:y]]
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
