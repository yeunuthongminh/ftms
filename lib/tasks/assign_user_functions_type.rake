require "rake"

namespace :db do
  desc "assign user type to user"
  task assign_user_function_type: :environment do

    puts "Assign Trainee Function"
    UserFunction.where(type: "TraineeFunction").find_each do |trainee_function|
      trainee_function.update_attributes type: "TraineeFunction"
    end

    puts "Assign Trainer Function"
    UserFunction.where(type: "TrainerFunction").find_each do |trainer_function|
      trainer_function.update_attributes type: "TrainerFunction"
    end

    puts "Assign Admin Function"
    UserFunction.where(type: "AdminFunction").find_each do |admin_function|
      admin_function.update_attributes type: "AdminFunction"
    end
  end
end
