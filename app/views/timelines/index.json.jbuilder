json.timeline do
  json.headline t("timeline.headline")
  json.type "default"
  json.text t("timeline.content")
  json.date @user_subjects do |user_subject|
    json.startDate l(user_subject.start_date, format: :timeline_js)
    json.endDate l(user_subject.end_date, format: :timeline_js)
    json.headline user_subject.subject.name
    json.text user_subject.description
    json.tag user_subject.status
    json.asset do
      list = ""
      user_subject.user_tasks.each do |user_task|
        list << "#{user_task.task_name}<br>"
      end
      json.media list
      json.credit "#{user_subject.user_tasks.complete.size} " +
        t("user_subject.task_finish") + "<br>#{user_subject.user_tasks.init.size} " +
        t("user_subject.task_init")
    end
  end
end
