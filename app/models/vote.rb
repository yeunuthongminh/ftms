class Vote < ApplicationRecord
  belongs_to :voter, polymorphic: true
  belongs_to :votable, polymorphic: true
end
