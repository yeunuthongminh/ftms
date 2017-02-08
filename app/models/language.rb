class Language < ApplicationRecord
  acts_as_paranoid

  has_many :courses, dependent: :destroy
  has_many :profiles, dependent: :destroy
end
