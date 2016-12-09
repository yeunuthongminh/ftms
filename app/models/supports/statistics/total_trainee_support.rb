class Supports::Statistics::TotalTraineeSupport < Supports::Statistics::ApplicationStatistic
  def total_trainees_presenter
    StatisticTotalTraineePresenter.new(total_trainee_by_month).render
  end

  private
  def total_trainee_by_month
    @statistics ||= Statistic.includes(:trainee_type, :language)
      .where.not(total_trainee: 0).order(:month)
      .where month: months.collect{|month| month.to_date.beginning_of_month},
        location_id: @location_ids, stage_id: @stage_ids
    total_trainees = {}

    load_trainee_types.each do |trainee_type|
      load_languages.each do |language|
        total_trainees[trainee_type: trainee_type.name,
          language: language.name] = Hash[months.collect {|item| [item, 0]}]
      end
    end

    @statistics.each do |statistic|
      if total_trainees[convert_to_hash statistic]
        total_trainees[convert_to_hash statistic][statistic.month
          .strftime I18n.t("datetime.formats.year_month")] += statistic.total_trainee
      end
    end

    total_trainees
  end
end
