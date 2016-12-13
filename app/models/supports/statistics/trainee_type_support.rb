class Supports::Statistics::TraineeTypeSupport < Supports::Statistics::ApplicationStatistic
  def trainee_types
    @trainee_types ||= if check
      load_trainee_types.collect{|u| Hash[:name, u.name, :y, u.profiles.size]}
        .reverse.take 1
    else
      temp = []
      load_locations.where(id: @location_ids).includes(profiles: :trainee_type)
        .each do |location|
        temp += location.profiles
          .collect{|p| p.trainee_type_name}.delete_if{|p| p.nil?}
      end
      temp.inject(Hash.new(0)) { |total, e| total[e] += 1; total}.to_a
        .collect {|e| Hash[:name, e.first, :y, e.last]}.sort_by{|u| u[:y]}.reverse
    end
  end

  def trainee_by_trainee_type
    @load_all_trainee_by_language ||= TraineeType.includes(:profiles)
      .collect{|u| Hash[:name, u.name, :y, u.profiles.size]}
      .sort_by {|u| u[:y]}.reverse
  end

  def presenters
    StatisticTraineeTypePresenter.new(trainee_by_trainee_type).render
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
