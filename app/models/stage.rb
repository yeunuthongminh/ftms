class Stage < ApplicationRecord
  acts_as_paranoid

  has_many :profiles, dependent: :destroy
end
