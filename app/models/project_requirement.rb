class ProjectRequirement < ApplicationRecord
  belongs_to :project
  belongs_to :project_user
end
