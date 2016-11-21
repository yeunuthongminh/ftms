class UserSubjectsController < ApplicationController
  load_and_authorize_resource

  def update
    @user_subject.update_status current_user, "waiting"
    user_course = @user_subject.user_course
    subject = @user_subject.subject
    if subject.subject_detail
      if @user_subject.locked?
        flash[:alert] = t "exams.lock_for_create"
        redirect_to user_course_subject_path user_course, subject
      else
        exam = ExamServices::NewExamService.new(user_subject: @user_subject).perform
        if exam
          redirect_to exam
        else
          flash[:alert] = t "exams.not_ready"
          redirect_to user_course_subject_path user_course, subject
        end
      end
    else
      flash[:success] = t "user_subjects.request_finish.success"
      redirect_to user_course_subject_path user_course, subject
    end
  end
end

