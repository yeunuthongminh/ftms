class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :group_projects, dependent: :destroy
  has_many :projects, through: :group_projects
end
