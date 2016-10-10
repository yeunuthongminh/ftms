class UserSubjectsController < ApplicationController
  load_and_authorize_resource

  def update
    @user_subject.update_status current_user, params["exam"]
    user_course = @user_subject.user_course
    if params["exam"] == "now"
      exam_service = ExamService.new @user_subject
      if exam_service.locked?
        flash[:alert] = t "exams.lock_for_create"
        redirect_to user_course_subject_path user_course, @user_subject.subject
      else
        exam = exam_service.new_exam
        if exam
          redirect_to exam
        else
          flash[:alert] = t "exams.not_ready"
          redirect_to user_course_subject_path user_course, @user_subject.subject
        end
      end
    else
      redirect_to user_course_subject_path user_course, @user_subject.subject
    end
  end
end
