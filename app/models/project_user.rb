class ProjectUser < ApplicationRecord
  belongs_to :project

  has_many :project_requirements, dependent: :destroy
end
