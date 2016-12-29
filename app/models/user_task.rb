class UserTask < ApplicationRecord
  serialize :pull_request_url
  acts_as_paranoid
  include PublicActivity::Model
  include ChatworkApi

  alias_attribute :trainee, :user

  has_many :activities, as: :trackable, class_name: "PublicActivity::Activity",
    dependent: :destroy
  has_many :user_task_histories, dependent: :destroy

  belongs_to :task
  belongs_to :user_subject
  belongs_to :user

  scope :user_task_of_subject_progress,
    -> {joins(:user_subject).where "user_subjects.status = ?",
      UserSubject.statuses[:progress]}
  scope :user_finished_task_in_day, ->course_id{joins(user_subject: :course).includes(:task, :user, :user_subject)
    .where("user_tasks.status = #{statuses[:finished]} AND
    date(user_tasks.updated_at) = '#{Date.today}' AND course_id = ? ",
    course_id).order(:user_id, :user_subject_id)}

  enum status: [:init, :inprogress, :onhold, :complete]

  delegate :id, :name, :image_url, :description, to: :task, prefix: true, allow_nil: true
  delegate :name, :id, to: :trainee, prefix: true, allow_nil: true
  delegate :description, to: :task, prefix: true, allow_nil: true

  before_save :update_sent_pull_count

  def nil_master?
    task.task_master_id.nil?
  end

  def create_by_trainee?
    task.create_by_trainee
  end

  def subject_in_progress?
    user_subject.progress?
  end

  def all_user_task_history
    self.user_task_histories.select{|user_task_history|
      user_task_history.created_at.to_date == Date.today.to_date}
  end

  private
  def update_sent_pull_count
    self.sent_pull_count += 1 if pull_request_url_changed?
  end
end
