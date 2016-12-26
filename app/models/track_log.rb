class TrackLog < ApplicationRecord
  include OrderScope

  belongs_to :user
end
