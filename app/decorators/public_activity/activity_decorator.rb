class PublicActivity::ActivityDecorator < Draper::Decorator
  delegate_all

  def owner_name
    h.link_to owner.name, path(owner)
  end

  def verb
    case key
    when "course.finish_course"
      I18n.t "activity.finish_course"
    when "course.start_course"
      I18n.t "activity.start_course"
    when "course.reopen_course"
      I18n.t "activity.reopen_course"
    when "user_subject.start_all_subject"
      I18n.t "activity.start_all_subject"
    when "user_subject.finish_all_subject"
      I18n.t "activity.finish_all_subject"
    when "user_task.change_status"
      I18n.t "activity.change_status_user_task"
    when "user_subject.change_status"
      I18n.t "activity.change_status_user_subject"
    else
      key
    end
  end

  def object_name
    get_object_from_trackable
  end

  def conjunction
    case key
    when "user_subject.start_subject", "user_subject.finish_subject"
      I18n.t "activity.for_subject"
    when "user_subject.start_all_subject", "user_subject.finish_all_subject"
      I18n.t "activity.in_subject"
    else
      ""
    end
  end

  def params
    case key
    when "user_task.change_status"
      "from #{I18n.t("user_tasks.statuses.#{parameters[:old_status]}")} to
        #{I18n.t("user_tasks.statuses.#{parameters[:new_status]}")}."
    when "user_subject.change_status"
      "from #{I18n.t("user_subjects.statuses.#{parameters[:old_status]}")} to
        #{I18n.t("user_subjects.statuses.#{parameters[:new_status]}")} for "
    else
      ""
    end
  end

  def recipient_name
    case key
    when "user_subject.change_status"
      h.link_to recipient.name, path(recipient)
    when "user_subject.start_all_subject", "user_subject.finish_all_subject"
      "#{trackable.subject_name}, #{recipient.name}"
    else
      ""
    end
  end

  def get_object_from_trackable
    case key
    when "course.finish_course", "course.start_course", "course.reopen_course"
      trackable.name
    when "user_subject.change_status"
      trackable.subject_name
    when "user_task.change_status"
      trackable.task_name
    else
      ""
    end
  end

  def path user
    if h.current_user.trainee?
      user
    else
      [h.namespace, user]
    end
  end
end
