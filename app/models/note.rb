class Note < ApplicationRecord
  acts_as_paranoid

  ATTRIBUTES_PARAMS = [:name, :evaluation_id, :user_id]

  belongs_to :trainee_evaluation
  belongs_to :author, class_name: User.name, foreign_key: :author_id
  belongs_to :target_user, class_name: User.name, foreign_key: :user_id

  validates :name, presence: true

  scope :load_notes, ->user_id, author_id{
    where user_id: user_id, author_id: author_id
  }
end
