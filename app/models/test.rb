class Test < ApplicationRecord
  acts_as_paranoid

  belongs_to :user_subject

  has_many :results, dependent: :destroy
  has_many :question, through: :results
end
