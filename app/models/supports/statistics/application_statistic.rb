class Supports::Statistics::ApplicationStatistic
  def initialize args = {}
    @check = args[:check]
    @location_ids = args[:location_ids] || load_locations.map(&:id)
    @check_params_location = args[:location_ids]
    @trainee_type_ids = args[:trainee_type_ids] || load_trainee_types.map(&:id)
    @stage_ids = args[:stage_ids] || load_stages.map(&:id)
    @start_date = args[:start_date] || Date.today.beginning_of_year
    @end_date = args[:end_date] || Date.today
  end

  def load_locations
    @locations ||= Location.all
  end

  def load_all_trainee
    @trainee_ids ||= Trainee.all.pluck :id
  end

  def load_trainee_types
    @load_trainee_types ||= TraineeType.all
  end

  def load_stages
    @stages ||= Stage.all
  end

  def month_ranges
    months
  end

  private
  def convert_to_hash statistic
    Hash[:trainee_type, statistic.trainee_type_name, :language,
      statistic.language_name]
  end

  def months
    date_range = @start_date..@end_date
    date_months = date_range.map {|d| Date.new(d.year, d.month, 1) }.uniq
    date_months.map {|d| d.strftime I18n.t('datetime.formats.year_month')}
  end

  def load_languages
    @languages ||= Language.all
  end
end
