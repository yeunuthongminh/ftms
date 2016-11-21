namespace :db do
  desc "Fix user_subject status"

  task fix_user_subject_status: :environment do
    puts "Updating user_subject status..."
    user_subjects = UserSubject.where "updated_at < ?", Time.new(2016, "nov", 19, 12, 30, 0)
    user_subjects.each do |user_subject|
      if user_subject.finish?
        user_subject.waiting!
      elsif user_subject.waiting?
        user_subject.finish!
      end
    end
  end
end
