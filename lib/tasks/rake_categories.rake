namespace :db do
  desc "Create categories"

  task rake_categories: :environment do
    category_names = [
      "Ruby on Rails",
      "Git",
      "MySQL",
      "Ruby Tutorial",
      "PHP Tutorial",
      "HTML-CSS",
      "JavaScript",
      "Android Tutorial",
      "Java Tutorial",
      "RSpec"
    ]
    category_names.each {|e| Category.find_or_create_by name: e}
    puts "Create categories success."
  end
end
