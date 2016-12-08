class Statistic < ApplicationRecord
  belongs_to :location
  belongs_to :stage
  belongs_to :trainee_type
  belongs_to :language

  delegate :name, to: :trainee_type, prefix: true, allow_nil: true
  delegate :name, to: :language, prefix: true, allow_nil: true
  delegate :name, to: :location, prefix: true, allow_nil: true
  delegate :name, to: :stage, prefix: true, allow_nil: true
end
