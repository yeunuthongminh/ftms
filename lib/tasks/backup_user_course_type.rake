require "json"

namespace :db do
  desc "Backup user_course type"
  # Only run before remove column user_type in user_course
  path = "/tmp/user_user_course_type.txt"
  task back_up_user_course_type: :environment do
    if !File.exists?(File.expand_path path)
      puts "Backup data..."
      content = UserCourse.pluck :id, :user_type
      str = JSON.dump(content)
      File.open(path, "w+") {|f| f.write(str)}
    else
      puts "File already exists!"
    end
  end
end
