class Project < ApplicationRecord
  has_many :project_requirements, dependent: :destroy
  has_many :group_projects, dependent: :destroy
  has_many :groups, through: :destroy

  ATTRIBUTES_PARAMS = [:name, project_requirements_attributes: [:name]]
end
