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

    admins = User.find_by("1")
    trainee = User.trainees.first
    trainer = User.trainers.first

    admin.roles << admin_role
    trainer.roles << trainer_role
    trainee.roles << trainee_role

    admin_role.functions.each do |function|
      UserFunction.find_or_create_by function: function, user: admin
    end

    trainer_role.functions.each do |function|
      UserFunction.find_or_create_by function: function, user: trainer
    end

    trainee_role.functions.each do |function|
      UserFunction.find_or_create_by function: function, user: trainee
    end
  end
end
