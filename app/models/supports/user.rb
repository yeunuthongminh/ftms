class Supports::User
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

  def notes
    @notes ||= Note.load_notes @user, current_user
  end
end
