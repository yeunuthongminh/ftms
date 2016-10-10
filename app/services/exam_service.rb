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
    question_points = Question.where(id: results.keys).map do |question|
      question.level_before_type_cast*unit
    end
    results.values.each_with_index do |answer_id, index|
      if Answer.find_by id: answer_id, is_correct: true
        exam_point += unit*question_points[index]
      end
    end
    exam.update_attributes score: exam_point
    exam_point
  end

  def locked?
    return true if @user_subject.exams.not_finished.size > 0 ||
      @user_subject.lock_for_create_exam?

    recent_exams = @user_subject.exams.finished.order("created_at DESC")
      .limit(Settings.exams.max_recent_exams).pluck(:created_at).reverse
    return false if recent_exams.size < Settings.exams.max_recent_exams

    duration = @user_subject.subject.subject_detail_time_of_exam.minutes.to_i
    current_time = (Time.zone.now - recent_exams.first).to_i
    if current_time < duration*4
      @user_subject.update_attributes lock_for_create_exam: true
      ResetPermissionExamJob.set(wait: Settings.exams.time_for_lock.hours)
        .perform_later @user_subject
      return true
    end
    false
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
