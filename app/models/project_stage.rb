class ProjectStage < ApplicationRecord
  has_many :project_requirements, dependent: :destroy
end
