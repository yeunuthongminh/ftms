class UserCourse < ApplicationRecord
  include PublicActivity::Model
  include InitUserSubject
  acts_as_paranoid

  #attr_readonly :user_type

  before_create :set_user_type
  after_create :create_user_subjects_when_assign_new_user
  before_save :restore_data

  belongs_to :trainer, foreign_key: :user_id
  belongs_to :trainee, foreign_key: :user_id
  belongs_to :admin, foreign_key: :user_id
  belongs_to :course

  delegate :name, :description, :start_date, :end_date, :status,
    :programming_language, to: :course, prefix: true, allow_nil: true

  has_many :user_subjects, dependent: :destroy
  has_many :trainee_evaluations, as: :targetable

  scope :course_progress, ->{joins(:course)
    .where("courses.status = ?", Course.statuses[:progress]).order :updated_at}
  scope :course_finished, ->{joins(:course)
    .where("courses.status = ?", Course.statuses[:finish])}
  scope :course_not_init, ->{joins(:course)
    .where("courses.status <> ?", Course.statuses[:init])}
  scope :find_user_by_role, ->role_id{joins(trainee: :user_roles)
    .where("user_roles.role_id = ?", role_id)}

  delegate :id, :name, to: :trainee, prefix: true, allow_nil: true
  delegate :id, :name, to: :trainer, prefix: true, allow_nil: true
  delegate :name, to: :course_programming_language, prefix: true, allow_nil: true

  enum status: [:init, :progress, :finish]
  enum user_type: [:admin, :trainer, :trainee]

  def set_user_type
    user = User.find_by id: self.user_id
    if user.instance_of? Admin
      self.user_type = Trainer.name.downcase
    else
      self.user_type = user.class.name.downcase
    end
  end

  private
  def create_user_subjects_when_assign_new_user
    if trainee
      create_user_subjects [self], course.course_subjects, course_id
    end
  end

  def restore_data
    if deleted_at_changed?
      restore recursive: true
    end
  end
end
