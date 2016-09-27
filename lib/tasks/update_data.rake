namespace :db do
  desc "rake update data"
  task update_data: :environment do
    Rake::Task["db:rake_course_location"].invoke
    Rake::Task["db:rake_trainee_progress"].invoke
  end

  task rake_course_location: :environment do
    Course.all.each do |course|
      location_id = course.load_trainers.first.try :profile_location_id
      course.update_attributes location_id: location_id
    end
    puts "Update location success"
  end

  task rake_trainee_progress: :environment do
    User.trainees.each do |trainee|
      user_subjects = UserSubject.where(user_id: trainee.id).order 'updated_at DESC'
      if user_subjects.size > 0
        if user_subject = user_subjects.finish.first
          user_subject.update_attributes current_progress: true
        elsif user_subject = user_subjects.progress.first
          user_subject.update_attributes current_progress: true
        end
      end
    end
    puts "Update current progress success"
  end
end
