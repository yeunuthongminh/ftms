require "rake"

namespace :db do
  desc "add for role base"
  task add_for_role_base: :environment do
    role_trainer = Role.find_by name: "Role base trainer"
    role_trainer.functions.create!([
      {model_class: "assign_user/courses", action: "edit"},
      {model_class: "assign_user/courses", action: "update"},
      {model_class: "change_status/courses", action: "update"},
      {model_class: "clone/courses", action: "create"},
      {model_class: "change_role/users", action: "edit"},
      {model_class: "change_role/users", action: "update"},
      {model_class: "export_file/pdfs", action: "show"},
      {model_class: "export_file/users", action: "show"},
      {model_class: "move_stage/users", action: "edit"},
      {model_class: "move_stage/users", action: "update"}
    ])
  end
end
