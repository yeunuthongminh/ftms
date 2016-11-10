class Supports::Subject
  attr_reader :subject

  def initialize args
    @subject = args[:subject]
    @course_id = args[:course_id]
  end

  def course_subject
    @course_subject ||= course.course_subjects.find do |course_subject|
      course_subject.subject_id == @subject.id
    end
  end

  def user_subjects
    @user_subjects ||= course_subject.user_subjects
  end

  def user_subjects_not_finishs
    @user_subjects_not_finishs ||= user_subjects.not_finish user_subjects.finish
  end

  def user_tasks_chart_data
    if user_subjects.any?
      @user_tasks_chart_data = {}

      user_subjects.each do |user_subject|
        @user_tasks_chart_data[user_subject.trainee_name] = user_subject
          .user_tasks.finished.size
      end
      @user_tasks_chart_data
    end
  end

  def course
    @course ||= Course.includes(course_subjects: :user_subjects)
      .find_by id: @course_id
  end

  def statuses
    @statuses ||= UserSubject.statuses
  end
end
