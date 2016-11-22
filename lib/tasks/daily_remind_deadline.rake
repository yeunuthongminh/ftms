namespace :db do
  desc "Daily remind deadline"

  task daily_remind_deadline: :environment do
    UserSubject.where("end_date >= :time",{time: "#{Time.now + 2.days}"}).each do |subject|
      unless subject.subject.subject_detail && subject.trainee.nil?
        room_id = subject.course_subject.chatwork_room_id
        users = [subject.trainee, subject.trainee.trainer]
        message = I18n.t "message_chatwork", user: subject.trainee.name,
          subject: subject.course_subject.subject_name, day: subject.end_date.day,
          month: subject.end_date.month
        subject.send_message_chatwork users: users, message: message, room_id: room_id
      end
    end
  end
end
