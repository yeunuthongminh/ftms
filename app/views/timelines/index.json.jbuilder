json.timeline do
  json.type "default"
  if @user_subjects.any?
    json.date @user_subjects do |user_subject|
      if user_subject.start_date
        json.startDate l(user_subject.start_date, format: :timeline_js)
      end
      if user_subject.user_end_date || user_subject.end_date
        json.endDate l(user_subject.user_end_date || user_subject.end_date,
          format: :timeline_js)
      end
      json.headline "#{link_to user_subject.subject.name,
        [user_subject.trainee_course, user_subject.subject], data: {status: user_subject.status}}"
      json.text "<div class='description'>#{user_subject.description}</div>"
      json.tag " "
      json.asset do
        image = image_url user_subject.subject.image_url ?
          user_subject.subject.image_url : "profile.png"
        list = ""
        user_subject.user_tasks.each.with_index 1 do |user_task, index|
          list << "<div class='user_task'><div class='task'
          data-finish='#{user_task.complete?}'>- #{user_task.task_name}</div></div>"
        end
        json.thumbnail image
        json.media list
        json.credit "<span class='text-danger'>
          #{user_subject.user_tasks.complete.size} " +
          t("tasks.task_finish") + "</span><span class='text-primary'><br>#{user_subject.user_tasks.init.size} " +
          t("tasks.task_init") + "<span>"
      end
    end
  end
end
