class Supports::UserSupport
  attr_reader :user, :current_user

  def initialize user
    @user = user
  end

  def activities
    @activities ||= PublicActivity::Activity.includes(:owner, :trackable)
      .user_activities(@user.id).recent.limit(20).decorate
  end

  def user_courses
    @user_courses ||= @user.user_courses
  end

  def finished_courses
    @finished_courses ||= @user.user_courses.course_finished
  end

  def inprogress_course
    @inprogress_course ||= @user.user_courses.course_progress.last
  end

  def user_subjects
    inprogress_course
    @user_subjects ||= @inprogress_course.user_subjects.includes(:course_subject)
      .order_by_course_subject if @inprogress_course
  end

  def note
    @note ||= Note.new
  end

  def managers
    @managers ||= User.not_trainees
  end

  def trainers
    @trainers ||= User.trainers.includes :profile
  end

  def stage
    @stage ||= @user.new_record? ? Stage.find_by(name: "In education") : @user.profile.stage
  end

  %w(roles universities programming_languages statuses user_types locations)
    .each do |objects|
    define_method objects do
      instance_variable_set "@#{objects}", objects.classify.constantize.all
    end
  end

  %w(location university user_type programming_language status).each do |object|
    define_method object do
      instance_variable_set "@#{object}", object.classify.constantize.new
    end
  end
end
