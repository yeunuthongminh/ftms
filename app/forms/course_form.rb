class CourseForm < Reform::Form
  property :name
  property :image
  property :description
  property :language_id
  property :location_id
  property :program_id
  property :start_date
  property :end_date
  property :subject_ids

  collection :documents, populate_if_empty: Document do
    property :id, writeable: false
    property :title
    property :document_link
    property :description
    property :_destroy, writeable: false
  end

  def save
    super do |attrs|
      if model.persisted?
        to_be_removed = ->(i) {i[:_destroy] == "1"}
        document_ids_to_rm = attrs[:documents].select(&to_be_removed).map {|i| i[:id]}
        Document.destroy document_ids_to_rm
        documents.reject! {|i| document_ids_to_rm.include? i.id}

        documents.reject! {|d| d.document_link.blank?}
      else
        documents.reject! {|d| d._destroy == "1"}
        documents.reject! {|d| d.document_link.blank?}
      end
    end

    super
  end
end
