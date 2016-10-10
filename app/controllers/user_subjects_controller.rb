class UserSubjectsController < ApplicationController
  load_and_authorize_resource

  def update
    @user_subject.update_status current_user, params["action"]
    user_course = @user_subject.user_course
    if params["action"] == "exam_now"
      exam = ExamService.new(@user_subject).new_exam
      if exam
        redirect_to exam
      else
        flash[:alert] = t "exams.not_ready"
        redirect_to user_course_subject_path user_course, @user_subject.subject
      end
    else
      redirect_to user_course_subject_path user_course, @user_subject.subject
    end
  end
end
