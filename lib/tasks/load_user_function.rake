namespace :db do
  desc "remake database data"
  task load_user_function: :environment do

    puts "create function"
    UserFunction.delete_all
    RoleFunction.delete_all
    Function.delete_all
    Rails.application.routes.routes.anchored_routes.map(&:defaults)
      .reject {|route| route[:internal] || Settings.controller_names.include?(route[:controller])}
      .each do |route|
      Function.find_or_create_by model_class: route[:controller],
        action: route[:action] unless route[:action] == "edit" || route[:action] == "new"
    end

    puts "create function for admin"
    admins = []
    Admin.all.each do |admin|
      Function.all.each do |function|
        admins << UserFunction.new(function: function, user: admin, type: "AdminFunction")
      end
    end
    UserFunction.import admins

    puts "create function for trainee"
    trainees = []
    Trainee.all.each do |trainee|
      Function.where("model_class NOT LIKE ?", "%/%").each do |function|
        trainees << UserFunction.new(function: function, user: trainee, type: "TraineeFunction")
      end
    end
    UserFunction.import trainees

    puts "create function for trainer"
    trainers = []
    Trainer.all.each do |trainer|
      Function.where("model_class LIKE ?", "trainer/%").each do |function|
        trainers << UserFunction.new(function: function, user: trainer, type: "TrainerFunction")
      end
    end
    UserFunction.import trainers
  end
end
