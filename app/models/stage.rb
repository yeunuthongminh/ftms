class Stage < ApplicationRecord
  has_many :profiles
  has_many :statistics, dependent: :destroy
end
