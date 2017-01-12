namespace :db do
  desc "Update data for version 1.2.1"

  task update_data_v_1_2_1: :environment do
    UserTask.where(sent_pull_count: nil).update_all sent_pull_count: 0
  end
end
