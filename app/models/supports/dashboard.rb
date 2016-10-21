class Supports::Dashboard
  attr_reader :end_date, :start_date

  def initialize
    @end_date = Date.today
    @start_date = Date.today - Settings.number_day_of_user_chart.day
  end

  def new_users_in_day
    @new_users ||= load_data User.created_between(@start_date, @end_date)
  end

  def new_courses_in_day
    @new_courses ||= load_data Course.created_between(@start_date, @end_date)
  end

  def finished_courses_in_day
    @finished_courses ||= load_data Course.finished_between(@start_date, @end_date)
  end

  private
  def load_data datas
    hash = {}
    (@start_date..@end_date).each do |date|
      datas.each do |data|
        if data.created_at.to_date == date && hash[date]
          hash[date] += 1
        elsif data.created_at.to_date == date
          hash[date] = 1
        elsif hash[date].nil?
          hash[date] = 0
        end
      end
    end
    hash = hash.map {|key, value| [key.to_s, value]}
  end
end
