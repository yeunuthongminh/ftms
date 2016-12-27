require "rake"

namespace :db do
  desc "assign user type to user"
  task assign_type: :environment do

    puts "Assign admin"
    User.first.update_attributes type: "Admin"

    puts "Assign Trainer"
    User.trainers.find_each do |user|
      user.update_attributes type: "Trainer"
    end

    puts "Assign Trainee"
    User.where(type: nil).each do |user|
      user.update_attributes type: "Trainee"
    end
  end
end
