namespace :db do
  desc "Update all current_progress to false"

  task false_current_progress: :environment do
    puts "Updating current_progresses to false..."
    Course.where(status: :finish).each do |course|
      course.user_subjects.update_all current_progress: false
    end
  end
end
