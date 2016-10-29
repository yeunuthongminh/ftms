class Supports::Statistic
  def initialize args = {}
    @location_ids = args[:location_ids]
    @start_date = args[:start_date]
    @end_date = args[:end_date]
    @stage_ids = args[:stage_ids]
  end

  def trainee_types
    @trainee_types ||= if @locations.nil?
      UserType.includes(:profiles).collect{|u| Hash[:name, u.name, :y, u.profiles.size]}
        .delete_if{|p| p[:y] == 0}.sort_by{|u| u[:y]}.reverse
    else
      temp = []
      Location.where(id: @location_ids).each do |location|
        temp += location.profiles.collect{|p| p.user_type_name}.delete_if{|p| p.nil?}
      end
      temp.inject(Hash.new(0)) { |total, e| total[e] += 1 ;total}.
        to_a.collect {|e| Hash[:name, e.first, :y, e.last]}.sort_by{|u| u[:y]}.reverse
    end
  end

  def universities
    @universities = University.includes(:profiles)
      .collect{|u| Hash[:name, u.name, :y, u.profiles.size]}.sort_by {|u| u[:y]}.reverse
  end

  def programming_languages
    @programming_languages = ProgrammingLanguage.includes(:profiles)
      .collect{|u| Hash[:name, u.name, :y, u.profiles.size]}.sort_by {|u| u[:y]}.reverse
  end

  def locations
    @locations = Hash[Location.includes(:profiles).collect{|u| [u.name, u.profiles.size]}]
  end

  def month_ranges
    months
  end

  def total_trainees_presenter
    @presenter ||= StatisticTotalTraineePresenter.new(total_trainee_by_month, months).render
  end

  def load_stages
    @stages ||= Stage.all
  end

  private
  def total_trainee_by_month
    @profiles = Profile.includes(:user_type, :programming_language)
      .where location_id: @location_ids, stage_id: @stage_ids
    total_trainees = {}

    UserType.all.each do |user_type|
      total_trainees[user_type] = {}
      ProgrammingLanguage.all.each do |language|
        total_trainees[user_type][language] = {}
        months.each do |month|
          total_trainees[user_type][language][month] = @profiles.select do |profile|
            profile.start_training_date && profile.start_training_date >= month.to_date.beginning_of_month &&
              profile.start_training_date <= month.to_date.end_of_month &&
              profile.programming_language == language && profile.user_type == user_type
          end.size
        end
      end
    end

    total_trainees
  end

  def months
    date_range = @start_date..@end_date
    date_months = date_range.map {|d| Date.new(d.year, d.month, 1) }.uniq
    date_months.map {|d| d.strftime I18n.t('datetime.formats.year_month')}
  end
end
