namespace :db do
  desc "remake database data"
  task make_stages: :environment do
    Rake::Task["db:create_stages"].invoke
    Rake::Task["db:assign_stages"].invoke
  end

  task create_stages: :environment do
    if Stage.all.blank?
      puts "Create stages"
      ["Resigned", "Joined div", "In education"].each do |stage|
        Stage.create name: stage
      end
    end
  end

  task assign_stages: :environment do
    trainees = 'Trainee'.safe_constantize ? Trainee.all : User.trainees
    trainees.each do |trainee|
      profile = trainee.profile
      stage_id = Stage.find_by(name: profile.status && profile.status.name == "Resigned" ? "Resigned" : "In education").id
      profile.update_attributes stage_id: stage_id
    end
    puts "Assign stage success!"
  end
end
