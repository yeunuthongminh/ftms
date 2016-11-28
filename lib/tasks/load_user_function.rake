namespace :db do
  desc "remake database data"
  task load_user_function: :environment do

    puts "create function"
    Rails.application.routes.set.anchored_routes.map(&:defaults).reject {|route| route[:internal] || route[:controller].include?("devise")}.each do |route|
      Function.find_or_create_by model_class: route[:controller], action: route[:action]
    end

    admin_role = Role.find_or_create_by name: "admin"
    trainer_role = Role.find_or_create_by name: "trainer"
    trainee_role = Role.find_or_create_by name: "trainee"

    Function.all.each do |function|
      RoleFunction.find_or_create_by function: function, role: admin_role
      RoleFunction.find_or_create_by function: function, role: trainer_role
      RoleFunction.find_or_create_by function: function, role: trainee_role
    end

    puts "create function for trainers"
    trainers = []
    Trainer.all.each do |trainer|
      Function.all.each do |function|
        trainers << trainer.user_functions.new(function: function, user: trainer, role_type: 1)
      end
    end
    UserFunction.import trainers

    puts "create function for trainees"
    trainees = []
    Trainee.all.each do |trainee|
      Function.all.each do |function|
        trainees << trainee.user_functions.new(function: function, user: trainee, role_type: 2)
      end
    end
    UserFunction.import trainees

    puts "create function for admin"
    admins = []
    Admin.all.each do |admin|
      Function.all.each do |function|
        admins << admin.user_functions.new(function: function, user: admin, role_type: 0)
      end
    end
    UserFunction.import admins
  end
end
