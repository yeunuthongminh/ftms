class Project < ApplicationRecord
  has_many :project_users, dependent: :destroy
  has_many :project_requirements, dependent: :destroy
end
