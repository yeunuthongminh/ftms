class QuestionForm < Reform::Form
  property :content
  property :category_id
  property :level

  collection :answers, populate_if_empty: Answer do
    property :id, writeable: false
    property :content
    property :is_correct
    property :_destroy, writeable: false
  end

  def save
    super do |attrs|
      if model.persisted?
        to_be_removed = ->(i) {i[:_destroy] == "1"}
        answer_ids_to_rm = attrs[:answers].select(&to_be_removed).map {|i| i[:id]}
        Answer.destroy answer_ids_to_rm
        answers.reject! {|i| answer_ids_to_rm.include? i.id}

        answers.reject! {|d| d.content.blank?}
      else
        answers.reject! {|d| d._destroy == "1"}
        answers.reject! {|d| d.content.blank?}
      end
    end

    super
  end
end
