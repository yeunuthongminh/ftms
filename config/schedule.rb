every :day, at: "11:55 pm" do
  command "backup perform --trigger fts_backup", output: "log/cronjob.log"
end

every :day, at: "11:30 pm" do
  rake "db:daily_report", output: "log/daily.log"
end

every :day, at: "7:45 am" do
  rake "db:daily_remind_deadline", output: "log/daily_deadline.log"
end

every :day, at: "11:50 pm" do
  rake "db:remake_statistic_data", output: "log/remake_statistic_data.log"
end
