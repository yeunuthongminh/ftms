module UsersMailerHelper

  def load_user_tasks course_id
    UserTask.user_finished_task_in_day course_id
  end
end
