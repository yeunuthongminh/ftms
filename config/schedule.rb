every :day, at: "11:55 pm" do
  command "backup perform --trigger fts_backup", output: "log/cronjob.log"
end

every :day, at: "11:30 pm" do
  rake "delayjob:mailday", output: "log/daily.log"
end
