class Supports::TraineeEvaluationSupport
  attr_reader :trainee_evaluation, :targetable

  def initialize args
    @trainee_evaluation = args[:trainee_evaluation]
    @targetable = args[:targetable]
  end

  def evaluation_standards
    @evaluation_standards ||= EvaluationStandard.all
  end

  def evaluation_standard_ids
    @evaluation_standard_ids ||= @trainee_evaluation.evaluation_check_lists
      .map &:evaluation_standard_id
  end

  def evaluation_check_lists_handler
    @evaluation_check_lists_handler ||= evaluation_standards.map do |standard|
      EvaluationCheckList.find_or_initialize_by evaluation_standard: standard,
        trainee_evaluation: @trainee_evaluation
    end
  end
end
