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
  end

  task rake_trainee_progress: :environment do
    CourseSubject.all.each do |course_subject|
      user_subjects = course_subject.user_subjects
      user_subjects.each do |user_subject|
        if user_subjects.size == user_subjects.where(current_progress: false)
          user_subject.update_attributes current_progress: true
        end
      end
    end
  end
end
