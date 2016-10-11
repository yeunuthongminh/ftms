class Group < ApplicationRecord
  acts_as_paranoid

  ATTRIBUTES_PARAMS = [:name, group_users_attributes: [:id, :user_id, :status,
    :_destroy]]

  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :group_projects, dependent: :destroy
  has_many :projects, through: :group_projects

  scope :group_of_user_in_course, ->course_id{joins(users: :user_courses)
    .where("user_courses.course_id = ?", course_id).distinct}

  before_create :group_name

  accepts_nested_attributes_for :group_users, allow_destroy: true

  private
  def group_name
    self.name = Date.today.to_s if self.name.blank?
  end
end
