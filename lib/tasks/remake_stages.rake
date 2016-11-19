namespace :db do
  desc "remake database data"
  task remake_stages: :environment do
    Rake::Task["db:create_stages"].invoke
    Rake::Task["db:assign_stages"].invoke
  end

  task create_stages: :environment do
    if Stage.all.blank?
      puts "Create stages"
      ["Resigned", "Joined div", "In education"].each do |stage|
        Stage.find_or_create_by name: stage
      end
    end
  end

  task assign_stages: :environment do
    trainees = "Trainee".safe_constantize ? Trainee.all : User.trainees
    trainees.each do |trainee|
      profile = trainee.profile
      if stage = Stage.find_by(name: profile.status && profile.status.name == "Resigned" ? "Resigned" : "In education")
        profile.update_attributes stage: stage
      end
    end
    puts "Assign stage success!"
  end
end
