require "json"

namespace :db do
  desc "Restore user_course type"
  # Only run after remove column user_type in user_courses
  task restore_user_course_type: :environment do
    path = "/tmp/user_user_course_type.txt"
    if File.exists?(File.expand_path path)
      puts "Restore user_course's type from file"
      str = File.read path
      content = JSON.load str
      content.each do |arr|
        user_course = UserCourse.find_by id: arr[0]
        user_course.update_attributes type: arr[1] == 2 ? "TraineeCourse" : "TrainerCourse"
      end
    else
      puts "File could not found!"
    end
  end
end
