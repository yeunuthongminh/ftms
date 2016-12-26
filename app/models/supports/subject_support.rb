class Supports::SubjectSupport
  attr_reader :subject

  def initialize args
    @subject = args[:subject]
    @course_id = args[:course_id]
  end

  def course_subject
    @course_subject ||= course.course_subjects.includes(:project).find do |course_subject|
      course_subject.subject_id == @subject.id
    end
  end

  def project_name
    @project_name ||= course_subject.project_name
  end

  def projects
    @projects ||= Project.all
  end

  def subject_content
    @subject_content ||= course_subject.subject_content
  end

  def user_subjects
    @user_subjects ||= course_subject.user_subjects.includes :user
  end

  def user_subjects_not_finishs
    @user_subjects_not_finishs ||= user_subjects.not_finish user_subjects.finish
  end

  def user_tasks_chart_data
    if user_subjects.any?
      @user_tasks_chart_data = {}

      user_subjects.each do |user_subject|
        @user_tasks_chart_data[user_subject.trainee.name] = user_subject
          .user_tasks.complete.size
      end
      @user_tasks_chart_data
    end
  end

  def course
    @course ||= Course.find_by id: @course_id
  end

  def statuses
    @statuses ||= UserSubject.statuses
  end
end
