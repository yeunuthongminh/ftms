class Supports::Question
  attr_reader :question

  def initialize question
    @question = question
  end

  def levels
    @levels ||= Question.levels.collect {|key, value| [key.humanize, key]}
  end

  def subjects
    @subjects ||= Subject.all
  end
end
