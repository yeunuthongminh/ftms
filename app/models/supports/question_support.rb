class Supports::QuestionSupport
  attr_reader :question

  def initialize question
    @question = question
  end

  def levels
    @levels ||= Question.levels.collect {|key, value| [key.humanize, key]}
  end

  def categories
    @categories ||= Category.all
  end
end
