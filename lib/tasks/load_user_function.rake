namespace :db do
  desc "remake database data"
  task load_user_function: :environment do

    puts "create function"
    Rails.application.routes.set.anchored_routes.map(&:defaults).reject {|route| route[:internal] || route[:controller].include?("devise")}.each do |route|
      Function.find_or_create_by model_class: route[:controller], action: route[:action]
    end

    puts "create function for admin"
    admins = []
    Admin.all.each do |admin|
      Function.all.each do |function|
        admins << UserFunction.new(function: function, user: admin, role_type: 0)
      end
    end
    UserFunction.import admins

    puts "create function for trainee"
    trainees = []
    Trainee.all.each do |trainee|
      Function.where("model_class NOT LIKE ?", "%/%").each do |function|
        trainees << UserFunction.new(function: function, user: trainee, role_type: 2)
      end
    end
    UserFunction.import trainees

    puts "create function for trainer"
    trainers = []
    Trainer.all.each do |trainer|
      Function.where("model_class NOT LIKE ?", "trainer/%").each do |function|
        trainers << UserFunction.new(function: function, user: trainer, role_type: 1)
      end
    end
    UserFunction.import trainers
  end
end
