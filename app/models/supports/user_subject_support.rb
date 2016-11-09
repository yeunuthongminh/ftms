class Supports::UserSubjectSupport
  attr_reader :user_subject

  def initialize args
    @user_subject = args[:user_subject]
    @course_subject_id = args[:course_subject_id]
  end

  def course_subject
    @course_subject = CourseSubject.includes(:course).find_by id: @course_subject_id
  end

  def course
    @course = course_subject.course
  end

  def subject
    @subject = course_subject.subject
  end

  def user_subjects
    @user_subjects = course_subject.user_subjects
  end

  def user_subjects_not_finishs
    @user_subjects_not_finishs = user_subjects.not_finish user_subjects.finish
  end

  def statuses
    @statuses ||= UserSubject.statuses
  end
end
