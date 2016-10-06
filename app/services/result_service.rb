class ResultService
  def initialize user_subject
    @user_subject = user_subject
    @subject = user_subject.subject
    @level_for_exam = Settings.exams.percent_question
    @level = Question.levels.map{|k,v| k.to_sym}
  end

  def new_exam level_for_exam = @level_for_exam
    number_of_question = @subject.subject_detail_number_of_question
    random_question @subject, number_of_question, @level, level_for_exam
    exam = @user_subject.exams.create
    if questions.size == number_of_question
      questions.pluck(:id).each{|id| exam.results.create question_id: id}
    else
      nil
    end
    exam
  end

  private
  def random_question subject, number_of_question, levels, level_for_exam
    questions = []
    n = number_of_question
    levels.each_with_index do |level, index|
      if index < levels.size - 1
        questions += subject.questions.random (number_of_question*level_for_exam[index]/100).to_i, level
        n -= number_of_question*level_for_exam[index]/100
      else
        questions += subject.questions.random n, level
      end
    end
    questions
  end
end
