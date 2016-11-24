class UserSubjectsController < ApplicationController
  before_action :load_user_subject

  def update
    authorize_with_multiple page_params.merge(record: @user_subject), SubjectPolicy
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
      room_id = @user_subject.course_subject.chatwork_room_id
      send_chatwork = @user_subject.send_message_chatwork users: [current_user, current_user.trainer],
        message: t("exams.request", user: current_user.name, subject: @user_subject.name),
        room_id: room_id
      redirect_to user_course_subject_path user_course, subject
    end
  end
end

