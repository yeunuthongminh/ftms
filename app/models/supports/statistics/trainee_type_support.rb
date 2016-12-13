class Supports::Statistics::TraineeTypeSupport < Supports::Statistics::ApplicationStatistic
  def trainee_types
    @trainee_types ||= percentage_trainee_by_trainee_type
  end

  def presenters
    StatisticTraineeTypePresenter.new(trainee_by_trainee_type).render
  end

  def trainee_by_trainee_type
    @load_trainee_by_location ||= Profile.where(user_id: load_all_trainee,
      location_id: @location_ids).includes :trainee_type

    unless @load_all_trainee_by_trainee_type
      none_trainee_type = Hash[:name, I18n.t("statistics.none"), :y, 0]
      all_trainee_types = TraineeType.all.map do |u|
        Hash[:name, u[:name], :y, 0]
      end
      @load_trainee_by_location.each do |trainee|
        if trainee.trainee_type
          found_trainee_type = all_trainee_types.find do |u|
            u[:name] == trainee.trainee_type.name
          end
          found_trainee_type[:y] += 1
        else
          none_trainee_type[:y] += 1
        end
      end
      all_trainee_types << none_trainee_type
      @load_all_trainee_by_trainee_type = all_trainee_types
        .sort_by {|u| u[:y]}.reverse
    end
    @load_all_trainee_by_trainee_type
  end

  def percentage_trainee_by_trainee_type
    list_trainee_types = trainee_by_trainee_type
    total_trainee = list_trainee_types.sum {|u| u[:y]}

    other_trainee_type = Hash[:name, I18n.t("statistics.other"), :y, 0]
    trainee_types = Array.new

    list_trainee_types.each do |trainee_type|
      percent = trainee_type[:y].to_f / total_trainee.to_f * 100
      if percent <= Settings.minimum_percent_to_join
        other_trainee_type[:y] += trainee_type[:y]
      else
        trainee_types << trainee_type
          .merge(extraValue: ActionController::Base.helpers
            .number_to_percentage(percent))
      end
    end
    if other_trainee_type[:y] > 0
      trainee_types << other_trainee_type
        .merge(extraValue: ActionController::Base.helpers
          .number_to_percentage(other_trainee_type[:y].to_f / total_trainee
            .to_f * 100))
    end
    trainee_types
  end

  private
  def check
    if @check.nil?
      false
    else
      if @check_params_location.nil?
        true
      end
    end
  end
end
