class Supports::UserSupport
  attr_reader :user, :current_user

  def initialize user
    @user = user
  end

  def activities
    @activities ||= PublicActivity::Activity.includes(:owner, :trackable)
      .user_activities(@user.id).order_desc(:created_at, 20).decorate
  end

  def user_courses
    @user_courses ||= @user.trainee_courses.includes(user_subjects: [:course, :trainee_course,
      :trainee_evaluations, :exams, {user_tasks: :task}, course_subject: :subject])
  end

  def finished_courses
    @finished_courses ||= user_courses.finish
  end

  def inprogress_course
    @inprogress_course ||= user_courses.find {|user_course| user_course.progress?}
  end

  def user_subjects
    @user_subjects ||= inprogress_course.user_subjects.includes([course_subject:
      :subject], user_tasks: :task).order_by_course_subject if inprogress_course
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

  %w(roles universities languages statuses trainee_types locations)
    .each do |objects|
    define_method objects do
      instance_variable_set "@#{objects}", objects.classify.constantize.all
    end
  end

  %w(location university trainee_type language status).each do |object|
    define_method object do
      instance_variable_set "@#{object}", object.classify.constantize.new
    end
  end

  def fa_background index
    case index
    when 1
      "bg-blue"
    when 2
      "bg-green"
    when 3
      "bg-orange"
    when 4
      "bg-blue"
    else
      "bg-red"
    end
  end

  def background_icon index
    case index
    when 1
      "primary"
    when 2
      "success"
    when 3
      "warning"
    when 4
      "info"
    else
      "danger"
    end
  end

  def link_user_subject user_subject, namespace
    namespace == Settings.namespace_roles.trainee ?
      [user_subject.trainee_course, user_subject.subject] :
      [namespace.to_sym, user_subject.course, user_subject.subject]
  end

  def link_exam exam, namespace
    namespace == Settings.namespace_roles.trainee ? exam :
      [namespace.to_sym, exam]
  end
end
