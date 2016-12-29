class TimelinesController < ApplicationController
  def index
    @user_subjects = current_user.user_subjects.includes course_subject: :subject,
      user_tasks: :task
  end
end
