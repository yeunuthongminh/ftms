class Document < ApplicationRecord
  acts_as_paranoid

  mount_uploader :document_link, DocumentUploader

  belongs_to :documentable, polymorphic: true

  def title
    if new_record?
      super
    else
      self[:title] = self[:title].blank? ? document_link.file.filename : self[:title]
    end
  end
end
