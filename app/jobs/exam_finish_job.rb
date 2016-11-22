class ExamFinishJob < ApplicationJob
  queue_as :urgent

  def perform exam
    exam.finish!
    point = ExamServices::CalculatePointService.new(exam).perform
    user_subject = exam.user_subject
    unless point < user_subject.subject.subject_detail_min_score_to_pass
      user_subject.update_status exam.trainee, "finish"
      trainee = user_subject.trainee
      room_id = user_subject.course_subject.chatwork_room_id
      send_chatwork = user_subject.send_message_chatwork users: [trainee, trainee.trainer],
        message: t("exams.pass", user: trainee.name, subject: user_subject.name),
        room_id: room_id
    end
  end
end
