class Supports::Statistics::InOutByMonthSupport < Supports::Statistics::ApplicationStatistic
  def trainee_in_out_by_month
    @trainee_in_out_by_month ||= trainee_in_out
  end

  private
  def trainee_in_out
    trainee_in = {}
    trainee_out = {}
    trainee_join_div = {}
    trainee_away = {}
    Profile.all.each do |profile|
      months.each do |month|
        trainee_in[month] = 0 unless trainee_in[month]
        trainee_out[month] = 0 unless trainee_out[month]
        trainee_join_div[month] = 0 unless trainee_join_div[month]
        trainee_away[month] = 0 unless trainee_join_div[month]
        if in_month? month, profile.start_training_date
          trainee_in[month] += 1
        elsif in_month? month, profile.leave_date
          trainee_out[month] += 1
        elsif in_month? month, profile.join_div_date
          trainee_join_div[month] += 1
        elsif in_month? month, profile.away_date
          trainee_away[month] += 1
        end
      end
    end

    {trainee_in: trainee_in, trainee_out: trainee_out,
      trainee_join_div: trainee_join_div, trainee_away: trainee_away}
  end

  def in_month? month, date
    date && date >= month.to_date.beginning_of_month &&
      date <= month.to_date.end_of_month
  end
end
