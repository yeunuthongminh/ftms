require "json"

namespace :db do
  desc "Backup user_task status"
  # Only run before remove table user_task_histories
  path = "/tmp/user_task_status.txt"
  task back_up_user_task_statuses: :environment do
    if !File.exists?(File.expand_path path)
      puts "Backup data..."
      content = UserTaskHistory.pluck :user_task_id, :status
      str = JSON.dump(content)
      File.open(path, "w+") {|f| f.write(str)}
    else
      puts "File already exists!"
    end
  end
end
