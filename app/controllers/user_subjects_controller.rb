class UserSubjectsController < ApplicationController
  before_action :load_user_subject

  def update
    authorize_with_multiple page_params.merge(record: @user_subject), SubjectPolicy
    @user_subject.update_status current_user, "waiting"
    user_course = @user_subject.user_course
    if @user_subject.locked?
      flash[:alert] = t "exams.lock_for_create"
      redirect_to user_course_subject_path user_course, @user_subject.subject
    else
      exam = ExamServices::NewExamService.new(user_subject: @user_subject).perform
      if exam
        redirect_to exam
      else
        flash[:alert] = t "exams.not_ready"
        redirect_to user_course_subject_path user_course, @user_subject.subject
      end
    end
  end
end
