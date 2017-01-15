class SubjectForm < Reform::Form
  property :name
  property :image
  property :description
  property :content
  property :during_time

  validates :name, presence: true
  validates :during_time, presence: true

  collection :task_masters, populate_if_empty: TaskMaster do
    property :id, writeable: false
    property :name
    property :description
    property :subject_id
    property :_destroy, writeable: false
  end

  collection :documents, populate_if_empty: Document do
    property :id, writeable: false
    property :title
    property :document_link
    property :documentable_id
    property :documentable_type
    property :description
    property :_destroy, writeable: false
  end

  property :subject_detail, populate_if_empty: :populate_subject_detail!,
    skip_if: :skip_subject_detail? do
    property :id, writeable: false
    property :number_of_question
    property :time_of_exam
    property :min_score_to_pass
    property :percent_of_questions
    property :category_questions
    property :_destroy, writeable: false

    validates :number_of_question, presence: true
    validates :time_of_exam, presence: true
    validates :min_score_to_pass, presence: true
  end

  def save
    super do |attrs|
      if model.persisted?
        validate_if_model_persited "task_master", attrs
        task_masters.reject! {|d| d.name.blank?}
        validate_if_model_persited "document", attrs
        documents.reject! {|d| d.title.blank?}
      else
        task_masters.reject! {|d| d._destroy == "1"}
        task_masters.reject! {|d| d.name.blank?}
        documents.reject! {|d| d._destroy == "1"}
        documents.reject! {|d| d.title.blank?}
      end
    end
    super
  end

  private
  def validate_if_model_persited model_type, attrs
    to_be_removed = ->(i) {i[:_destroy] == "1"}
    ids_to_rm = attrs["#{model_type.pluralize}".to_sym].select(&to_be_removed)
      .map {|i| i[:id]}
    Object.const_get("#{model_type.classify}").destroy ids_to_rm
    send("#{model_type.pluralize}").reject! {|i| ids_to_rm.include? i.id}
  end

  def skip_subject_detail?(fragment:, **)
    if fragment[:_destroy] == "1"
      true
    else
      false
    end
  end

  def populate_subject_detail!(fragment:, **)
    if fragment[:_destroy] == "1"
      SubjectDetail.new
    else
      SubjectDetail.new number_of_question: fragment[:number_of_question],
        time_of_exam: fragment[:time_of_exam],
        min_score_to_pass: fragment[:min_score_to_pass],
        percent_of_questions: fragment[:percent_of_questions],
        category_questions: fragment[:category_questions]
    end
  end
end
