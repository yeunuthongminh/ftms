class Question < ApplicationRecord
  acts_as_paranoid

  ATTRIBUTES_PARAMS = [:content, :category_id, :level,
    answers_attributes: [:id, :content, :is_correct, :_destroy]]

  belongs_to :category

  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :exams, through: :results

  validates :content, presence: true

  scope :random, ->count, level, category_id{where(level: level, category_id: category_id)
    .order("RAND()").limit(count)}

  enum level: [:easy, :normal, :hard]

  delegate :name, to: :category, prefix: true, allow_nil: true
end
