class Answer < ApplicationRecord
  acts_as_paranoid

  belongs_to :question

  has_many :results, dependent: :destroy
end
