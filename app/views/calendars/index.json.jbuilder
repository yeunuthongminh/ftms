json.array!(@user_subjects) do |user_subject|
  if user_subject.end_date
    json.title user_subject.subject.name
    json.start user_subject.start_date
    json.end user_subject.end_date.try :midday
    json.url user_course_subject_path user_subject.user_course_id,
      user_subject.course_subject.subject_id
    if user_subject.user_tasks.any?
      json.task_user user_subject.user_tasks.select{|user_task| user_task.inprogress?}
        .map{|user_task| user_task.task.name}.join('/')
    end
  end
end
