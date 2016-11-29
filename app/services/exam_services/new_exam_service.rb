class ExamServices::NewExamService
  attr_reader :args

  def initialize args
    @user_subject = args[:user_subject]
    @level_for_exam = args[:level_for_exam]
    @level_for_exam ||= Settings.exams.percent_question
    @category_questions = args[:category_questions]
  end

  def perform
    subject = @user_subject.subject
    number_of_question = subject.subject_detail_number_of_question
    questions = random_question number_of_question, @category_questions, @level_for_exam
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
  def random_question number_of_question, category_questions, level_for_exam
    levels = questions_for_level level_for_exam, number_of_question
    questions = make_list_questions category_questions, levels
    questions.size == number_of_question ? questions : nil
  end

  def make_list_questions category_questions, levels
    categories = category_questions.sort_by {|_key, value| value}
    questions = []

    categories.each_with_index do |category, c_index|
      levels.each_with_index do |level, l_index|
        temp_take = level[1]

        if level[1] > category[1]
          level[1] -= category[1]
          temp_take = category[1]
          category[1] = 0
        elsif level[1] == category[1]
          levels -= [level]
          category[1] = 0
        else
          category[1] -= level[1]
          levels -= [level]
        end
        questions += Question.random temp_take, level[0], category[0]
        break if category[1] == 0
      end
    end
    questions
  end

  def questions_for_level level_for_exam, total_questions
    temp_sum = 0
    lvls = {}
    [:easy, :normal, :hard].each_with_index{|e,i| lvls[e] = level_for_exam[i]}
    lvl_array = lvls.to_a
    lvl_array.each_with_index do |e, index|
      if index < level_for_exam.length - 1
        lvl_array[index][1] = (e[1]*total_questions/100).to_i
        temp_sum += lvl_array[index][1]
      else
        lvl_array[index][1] = total_questions - temp_sum
      end
    end
    lvl_array.reverse
  end
end
