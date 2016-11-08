require "rake"

namespace :db do
  desc "assign user type to user"
  task assign_type: :environment do

    puts "Assign Trainee"
    User.trainees.find_each do |user|
      user.update_attributes type: "Trainee"
    end

    puts "Assign Trainer"
    User.trainers.find_each do |user|
      user.update_attributes type: "Trainer"
    end

    puts "Assign admin"
    User.first.update_attributes type: "Admin"

    desc "assign user type to user course"
    UserCourse.find_each do |user_course|
      user = User.find_by id: user_course.user_id
      user_course.send("#{user.class.name.downcase}!")
    end
  end
end
