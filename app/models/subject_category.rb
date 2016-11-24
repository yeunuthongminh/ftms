class SubjectCategory < ApplicationRecord
  belongs_to :subject
  belongs_to :category
end
