namespace :db do
  desc "remake database data"
  task reload_data: :environment do
    Rake::Task["db:migrate:reset"].invoke

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

    trainers = []
    User.trainers.each do |trainer|
      Function.all.each do |function|
        trainers << UserFunction.new(function: function, user: trainer)
      end
    end
    UserFunction.import trainers

    trainees = []
    User.trainees.each do |trainee|
      Function.all.each do |function|
        trainees << UserFunction.new(function: function, user: trainee)
      end
    end
    UserFunction.import trainees

    admins = []
    User.admin_roles.each do |admin|
      Function.all.each do |function|
        admins << UserFunction.new(function: function, user: admin)
      end
    end
    UserFunction.import admins
  end
end
