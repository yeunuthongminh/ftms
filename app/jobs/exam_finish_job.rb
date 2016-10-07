class ExamFinishJob < ApplicationJob
  queue_as :urgent

  def perform exam
    exam.finish!
    ExamService.new(exam.user_subject).calculate_point exam
    unless point < exam.user_subject.subject.subject_detail_min_score_to_pass
      exam.user_subject.finish!
    end
  end
end
