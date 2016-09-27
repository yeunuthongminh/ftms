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
      puts "Update location #{course} success"
    end
  end

  task rake_trainee_progress: :environment do
    CourseSubject.all.each do |course_subject|
      user_subjects = course_subject.user_subjects
      if user_subjects.progress.size > 0 && user_subjects.finish.size > 0
        user_subjects.finish.order("updated_at DESC").first
          .update_attributes current_progress: true
        puts "Update current progress #{course_subject} success"
      end
    end
  end
end
