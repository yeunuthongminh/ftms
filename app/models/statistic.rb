class Statistic < ApplicationRecord
  belongs_to :location
  belongs_to :stage
  belongs_to :user_type
  belongs_to :language

  delegate :name, to: :user_type, prefix: true, allow_nil: true
  delegate :name, to: :language, prefix: true, allow_nil: true
  delegate :name, to: :location, prefix: true, allow_nil: true
  delegate :name, to: :stage, prefix: true, allow_nil: true
end
