class ExamServices::CalculatePointService
  def initialize exam
    @exam = exam
  end

  def perform
    results = @exam.results.pluck(:question_id, :answer_id).to_h
    unit = Settings.exams.unit
    exam_point = 0
    question_points = Question.where(id: results.keys).map do |question|
      (question.level_before_type_cast + 1)*unit
    end
    results.values.each_with_index do |answer_id, index|
      if Answer.find_by id: answer_id, is_correct: true
        exam_point += unit*question_points[index]
      end
    end
    @exam.update_attributes score: exam_point
    exam_point
  end
end
