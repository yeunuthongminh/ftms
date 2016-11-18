class Statistic < ApplicationRecord
  belongs_to :location
  belongs_to :stage
  belongs_to :user_type
  belongs_to :programming_language
end
