class Supports::TraineeEvaluationSupport
  attr_reader :trainee_evaluation, :targetable, :evaluation_template

  def initialize args
    @trainee_evaluation = args[:trainee_evaluation]
    @targetable = args[:targetable]
    @filter_service = args[:filter_service]
    @namespace = args[:namespace]
    @current_user = args[:current_user]
    @evaluation_template = args[:evaluation_template]
  end

  def evaluation_standards
    @evaluation_standards ||= EvaluationStandard.all
  end

  def evaluation_templates
    @evaluation_templates ||= EvaluationTemplate.all.collect {|object| [object.name,
      object.id]}
  end

  def trainee_evaluations
    @trainee_evaluations ||= if @current_user.is_admin?
      TraineeEvaluation.includes :trainee
    else
      @current_user.trainee_evaluations.includes :trainee
    end
  end

  def filter_data_user
    @filter_data_user ||= @filter_service.user_filter_data
  end

  def trainee_evaluation_presenters
    @trainee_evaluation_presenters ||= TraineeEvaluationPresenter.new(namespace:
      @namespace, trainee_evaluations: trainee_evaluations,
      current_user: @current_user).render
  end
end
