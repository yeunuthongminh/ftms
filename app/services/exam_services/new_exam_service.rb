class ExamServices::NewExamService
  attr_reader :args

  def initialize args
    @user_subject = args[:user_subject]
    @level_for_exam = args[:level_for_exam]
    @level_for_exam ||= Settings.exams.percent_question
    @level = Question.levels.map{|k,v| k.to_sym}
  end

  def perform
    subject = @user_subject.subject
    number_of_question = subject.subject_detail_number_of_question
    questions = random_question subject, number_of_question, @level, @level_for_exam
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
    questions.size == number_of_question ? questions.shuffle : nil
  end
end
