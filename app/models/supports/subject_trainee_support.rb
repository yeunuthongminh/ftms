class Supports::SubjectTraineeSupport
  attr_reader :subject, :args

  def initialize args
    @subject = args[:subject]
    @user_course_id = args[:user_course_id]
  end

  def course_subject
    @course_subject ||= CourseSubject.includes(
      user_subjects: [:trainee_course, :course])
      .find_by course_id: user_course.course_id, subject_id: @subject.id
  end

  def project
    @project ||= course_subject.project
  end

  def course
    @course ||= course_subject.course
  end

  def user_subject
    @user_subject ||= course_subject.user_subjects
      .find{|user_subject| user_subject.user_id == user_course.user_id}
  end

  def trainers
    @trainers ||= user_subject.course.trainers
  end

  def trainees
    @trainees ||= user_subject.course.trainees
  end

  def users
    @user ||= (trainees + trainers).take Settings.number_member_show
  end

  def member_size
    @member_size ||= trainers.size + trainees.size
  end

  def count_member
    @count_member ||= trainers.size + trainees.size - Settings.number_member_show
  end

  def user_tasks
    @user_tasks ||= user_subject.user_tasks.includes :task, :user, :user_subject
  end

  def task_statuses
    @task_statuses ||= UserTask.statuses
  end

  def task_new
    @task_new ||= Task.new
  end

  def user_task_handle
    @user_task_handle ||= task_new.user_tasks.build
  end

  def user_course
    @user_course ||= UserCourse.includes(:user).find_by id: @user_course_id
  end

  UserTask.statuses.each do |key, value|
    define_method "number_of_task_#{key}" do
      instance_variable_set "@number_of_task_#{key}", user_tasks.send(key).size
    end
  end

  def user_tasks_chart_data
    unless user_subject.init?
      @user_tasks_chart_data = {}

      course_subject.user_subjects.includes(:user, :trainee_course)
        .each do |user_subject|
        @user_tasks_chart_data[user_subject.user_name] = user_subject.user_tasks
          .complete.size
      end
      @user_tasks_chart_data
    end
  end

  def exam_process
    user_subject.exams.last
  end
end
