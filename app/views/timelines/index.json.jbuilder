json.timeline do
  json.headline "<span class=\"text-white\">#{t "timeline.headline"}</span>"
  json.type "default"
  json.text "<span class=\"text-biscue\">#{t "timeline.content"}</span>"
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
        [user_subject.trainee_course, user_subject.subject]}"
      json.text "<div class=\"description\">#{user_subject.description}</div>"
      json.tag "<span class=\"label-status
        #{set_background_color_status user_subject.status}\">
        #{t "user_subjects.statuses.#{user_subject.status}"}</span>"
      json.asset do
        list = ""
        user_subject.user_tasks.each.with_index 1 do |user_task, index|
          list << "#{index} - #{user_task.task_name}<br>"
        end
        json.media list
        json.credit "<span class=\"text-danger\">
          #{user_subject.user_tasks.complete.size} " +
          t("tasks.task_finish") + "</span><span class=\"text-primary\"><br>#{user_subject.user_tasks.init.size} " +
          t("tasks.task_init") + "<span>"
      end
    end
  end
end
