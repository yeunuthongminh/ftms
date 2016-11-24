class Project < ApplicationRecord
  acts_as_paranoid

  ATTRIBUTES_PARAMS = [:name, project_requirements_attributes: [:id, :name,
    :_destroy]]

  has_many :project_requirements, dependent: :destroy
  has_many :course_subjects

  validates :name, presence: true

  accepts_nested_attributes_for :project_requirements,
    allow_destroy: true, reject_if: lambda {|a| a[:name].blank?}
end
