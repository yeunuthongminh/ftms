module NotificationHelper
  def notification_content notification
    trackable = notification.trackable

    if trackable.class.name == Course.name
      content = t "layouts.course"
      content << t("notifications.keys.#{notification.key}",
        data: notification.trackable.name) if notification.key
      content << notification.user_name
    elsif trackable.class.name == UserSubject.name
      content = t("layouts.subject") << notification.user_name
      content << t("notifications.keys.#{notification.key}",
        data: notification.trackable.course_subject.subject_name) if notification.key
      content << I18n.t("statuses.#{notification.parameters}") if notification.parameters
    elsif trackable.class.name == CourseSubject.name
      content = "#{I18n.t "layouts.assign_project"}"
      content << notification.user_name
      content << "#{I18n.t "notifications.keys.#{notification.key}",
        course_subject: notification.trackable.subject_name, data_project_name: notification[:parameters]}"
    end
    content
  end

  def notification_image notification
    trackable = notification.trackable
    if trackable.class.name == "Course"
      image_object = trackable
    elsif trackable.class.name == "UserSubject"
      image_object = trackable.course_subject
    elsif trackable.class.name == "CourseSubject"
      image_object = trackable.course
    end

    set_image image_object, Settings.image_size_40
  end

  def not_seen_notification
    if (size = @notifications.where(seen: false).size) > 0
      size
    end
  end

  def notification_link notification
    trackable = notification.trackable
    if trackable.class.name == "Course"
      trackable
    elsif trackable.class.name == "UserSubject"
      user_course_subject_path trackable.user_course_id,
        trackable.course_subject.subject_id
    elsif trackable.class.name == "CourseSubject"
      user_notication = UserNotification.find_by notification_id: notification.id
      user_course = UserCourse.find_by course_id: trackable.course_id,
        user_id: user_notication.user_id
      user_course_subject_path user_course, trackable.subject
    end
  end
end
