namespace :db do
  desc "Update university abbreviation"

  task update_university_abbr: :environment do
    puts "Updating university abbreviation"
    University.where(abbreviation: nil).each do |university|
      abbr = university.name.scan(/\p{Upper}/).join ""
      university.update_attributes abbreviation: abbr
    end
  end
end
