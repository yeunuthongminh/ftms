class Supports::UserCourseSupport
  attr_reader :user_course

  def initialize user_course
    @user_course = user_course
  end

  def course
    @course ||= @user_course.course
  end

  def users
    @users ||= course.users
  end

  def user_subjects
    @user_subjects ||= @user_course.user_subjects
      .includes(course_subject: :subject).order_by_course_subject
  end

  def count_member
    @count_member ||= users.size - Settings.number_member_show
  end

  def number_of_user_subjects
    @number_of_user_subjects ||= user_subjects.size
  end

  def user_subject_statuses
    @user_subject_statuses ||= UserSubject.statuses
  end

  UserSubject.statuses.each do |key, value|
    define_method "number_of_user_subject_#{key}" do
      instance_variable_set "@number_of_user_subject_#{key}",
        user_subjects.send(key).size
    end
  end
end
