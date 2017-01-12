require "rake"

namespace :db do
  desc "add role base"
  task role_base: :environment do


    puts "delete"
    UserFunction.delete_all
    RoleFunction.delete_all
    Function.delete_all

    puts "create function"
    Rails.application.routes.routes.anchored_routes.map(&:defaults)
      .reject {|route| route[:internal] || Settings.controller_names.include?(route[:controller])}
      .each do |route|
      Function.find_or_create_by model_class: route[:controller],
        action: route[:action] unless route[:action] == "edit" || route[:action] == "new"
    end

    puts "create role base"
    role_functions = []
    ["Role_Base_Trainee", "Role_Base_Trainer"].each do |role|
      Role.create name: role
    end
  end
end
