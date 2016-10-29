namespace :db do
  desc "remake database data"
  task create_stages: :environment do
    puts "Create stages"
    ["Resigned", "Joined div", "In education"].each do |stage|
      Stage.create name: stage
    end
  end
end
