class DailyPostView < ApplicationRecord
  acts_as_paranoid

  belongs_to :post
end
