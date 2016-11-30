namespace :db do
  desc "Reset ready_for_project"

  task reset_ready_for_project: :environment do
    Profile.update_all ready_for_project: nil
  end
end
