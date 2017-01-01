class TraineeEvaluationForm < Reform::Form
  property :targetable_type
  property :targetable_id
  property :total_point
  property :user_id

  collection :evaluation_check_lists, populate_if_empty: EvaluationCheckList do
    property :id, writeable: false
    property :score
    property :trainee_evaluation_id
    property :evaluation_standard_id
    property :user_id
    property :name
    property :use
    property :_destroy, writeable: false
  end

  def save
    super do |attrs|
      if model.persisted?
        validate_if_model_persited "evaluation_check_list", attrs
        evaluation_check_lists.reject! {|d| d.name.blank?}
      else
        evaluation_check_lists.reject! {|d| d._destroy == "true"}
        evaluation_check_lists.reject! {|d| d.name.blank?}
      end
    end
    super
  end

  def validate_if_model_persited model_type, attrs
    to_be_removed = ->(i) {i[:_destroy] == "true"}
    ids_to_rm = attrs["#{model_type.pluralize}".to_sym].select(&to_be_removed)
      .map {|i| i[:id]}
    Object.const_get("#{model_type.classify}").destroy ids_to_rm
    send("#{model_type.pluralize}").reject! {|i| ids_to_rm.include? i.id}
  end
end
