class GroupUser < ApplicationRecord
  acts_as_paranoid

  belongs_to :group
  belongs_to :user
end
