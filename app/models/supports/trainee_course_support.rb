class Supports::TraineeCourseSupport
  attr_reader :trainee_course

  def initialize trainee_course
    @trainee_course = trainee_course
  end

  def course
    @course ||= @trainee_course.course
  end

  def trainers
    @trainers ||= course.trainers
  end

  def trainees
    @trainees ||= course.trainees
  end

  def users
    @users ||= (trainees + trainers).take Settings.number_member_show
  end

  def member_size
    @member_size ||= trainers.size + trainees.size
  end

  def user_subjects
    @user_subjects ||= @trainee_course.user_subjects
      .includes(course_subject: :subject).order_by_course_subject
  end

  def count_member
    @count_member ||= member_size - Settings.number_member_show
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
        user_subjects.select{|user_subject| user_subject.send "#{key}?"}.size
    end
  end
end
