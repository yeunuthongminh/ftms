namespace :db do
  task create_test_permission: :environment do
    puts "Creating Permissions"

    trainer_permissions = {
      Answer: ["read", "update"],
      Exam: ["read", "update"],
      Question: ["read", "update"],
      Result: ["read", "update"]
    }

    trainee_permissions = {
      Answer: ["read"],
      Exam: ["read"],
      Question: ["read"],
      Result: ["read", "update"]
    }

    trainer_permissions.each do |permission|
      permission[1].each do |action|
        Permission.create! model_class: permission[0], action: action, role_id: 2
      end
    end

    trainee_permissions.each do |permission|
      permission[1].each do |action|
        Permission.create! model_class: permission[0], action: action, role_id: 3
      end
    end
  end
end
