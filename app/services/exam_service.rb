class ExamService
  def initialize user_subject
    @user_subject = user_subject
    @level_for_exam = Settings.exams.percent_question
    @level = Question.levels.map{|k,v| k.to_sym}
  end

  def new_exam level_for_exam = @level_for_exam
    subject = @user_subject.subject
    number_of_question = subject.subject_detail_number_of_question
    questions = random_question subject, number_of_question, @level, level_for_exam
    if questions
      duration = subject.subject_detail_time_of_exam ?
        subject.subject_detail_time_of_exam : Settings.exams.duration
      exam = @user_subject.exams.create duration: duration,
        spent_time: duration, user_id: @user_subject.user_id
      questions.pluck(:id).each{|id| exam.results.create question_id: id}
      exam
    else
      nil
    end
  end

  def calculate_point exam
    results = exam.results.pluck(:question_id, :answer_id).to_h
    unit = Settings.exams.unit
    exam_point = 0
    question_points = Question.where(id: results.keys).pluck(:level).map{|v| v*unit}
    results.values.each_with_index do |answer_id, index|
      if Answer.find_by id: answer_id, is_correct: true
        exam_point += unit*question_points[index]
      end
    end
    exam.update_attributes score: exam_point
    exam_point
  end

  private
  def random_question subject, number_of_question, levels, level_for_exam
    n = number_of_question
    return nil if n.nil?
    questions = []
    levels.each_with_index do |level, index|
      if index < levels.size - 1
        count_question = (number_of_question*level_for_exam[index]/100).to_i
        questions += subject.questions.random count_question, level
        n -= count_question
      else
        questions += subject.questions.random n, level
      end
    end
    questions.size == number_of_question ? questions : nil
  end
end
