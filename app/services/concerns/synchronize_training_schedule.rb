module SynchronizeTrainingSchedule
  def synchronize title
    worksheet = @file.worksheet_by_title title
    worksheet.list.each do |line|
      trainee = User.find_by_name line[Settings.sync.training_schedules.name].strip

      start_training_date = get_date line[Settings.sync.training_schedules.start_training_date]
      leave_date = get_date line[Settings.sync.training_schedules.leave_date]
      finish_training_date = get_date line[Settings.sync.training_schedules.finish_training_date]
      graduation = get_date line[Settings.sync.training_schedules.graduation]
      trainee_type = find_object UserType, line[Settings.sync.training_schedules.trainee_type]
      university = find_object University, line[Settings.sync.training_schedules.university]
      programming_language = find_object ProgrammingLanguage,
        line[Settings.sync.training_schedules.programming_language]
      location = find_object Location, line[Settings.sync.training_schedules.location]
      working_day = line[Settings.sync.training_schedules.working_day]
      staff_code = line[Settings.sync.training_schedules.staff_code]
      join_div_date = line[Settings.sync.training_schedules.join_div_date]
      status = find_status line[Settings.sync.training_schedules.status].strip
      stage = find_stage status
      ready_for_project = get_date line[Settings.sync.training_schedules.ready_for_project]
      trainer = find_trainer line[Settings.sync.training_schedules.trainer]

      if trainee
        trainee.leave_date ||= leave_date
        trainee.finish_training_date ||= finish_training_date
        trainee.graduation ||= graduation
        trainee.user_type ||= trainee_type
        trainee.university ||= university
        trainee.programming_language ||= programming_language
        trainee.location ||= location
        trainee.working_day ||= working_day
        trainee.staff_code ||= staff_code
        trainee.join_div_date ||= join_div_date
        trainee.status ||= status
        trainee.stage ||= stage
        trainee.ready_for_project ||= ready_for_project
        trainee.trainer_id ||= trainer.try :id
      else
        name = line[Settings.sync.training_schedules.name].strip
        email = convert_to_email name

        trainee = Trainee.new name: line[Settings.sync.training_schedules.name],
          email: email, trainer_id: trainer.try(:id)
        trainee.build_profile start_training_date: start_training_date,
          leave_date: leave_date,
          finish_training_date: finish_training_date,
          graduation: graduation,
          user_type: trainee_type,
          university: university,
          programming_language: programming_language,
          location: location,
          working_day: working_day,
          staff_code: staff_code,
          join_div_date: join_div_date,
          status: status,
          stage: stage,
          ready_for_project: ready_for_project,
          user_progress_id: nil,
          created_at: start_training_date,
          updated_at: start_training_date
      end

      trainee.save!
    end

  end

  private
  def get_date column
    if column[Settings.sync.training_schedules.leave_date] &&
      (temp = column[Settings.sync.training_schedules.leave_date].strip)
      temp.to_date
    else
      nil
    end
  end

  def find_object model, name
    model.find_or_create_by (model == University ? "abbreviation" : "name").to_sym => name.strip
  end

  def find_status name
    if ["Away from Training(~ 2 month)", "Away from Training(2 month)"].include? name
      Status.find_by name: "Pending"
    elsif "In Progress" == name
      Status.find_by name: "In Progress"
    elsif "Joined Edu Project" == name
      Status.find_by name: "Joined Edu Project"
    elsif "Joined Project" == name
      Status.find_by name: "Joined Project"
    elsif "Resigned" == name
      Status.find_by name: "Resigned"
    elsif "Will go to Japan" == name

    end
  end

  def find_stage status
    case status.name
    when "In Progress"
      Stage.find_by name: "In education"
    when "Resigned"
      Stage.find_by name: "Resigneds"
    when "Prepare project"
      Stage.find_by name: "In education"
    when "Joined Project"
      Stage.find_by name: "Joined div"
    when "Joined Edu Project"
      Stage.find_by name: "In education"
    when "Pending"
      Stage.find_by name: "In education"
    end
  end

  def convert_name name
    name = name.downcase
    hash_convert = Hash[/[àáảãạăằắẳẵặâầấẩẫậ]/, "a",
      /[đ]/, "d",
      /[èéẻẽẹêềếểễệ]/, "e",
      /[ìíỉĩị]/, "i",
      /[òóỏõọôồốổỗộơờớởỡợ]/, "o",
      /[ùúủũụưừứửữự]/, "u",
      /[ỳýỷỹỵ]/, "y"]

    hash_convert.each do |key, value|
      name = name.gsub key, value
    end
    name
  end

  def convert_to_email name
    convert_name(name).gsub(" ", ".") + "@framgia.com"
  end

  def convert_to_abbr name
    array_name = convert_name(name).split " "
    if array_name.last.length == 1
      first_name = array_name.last(2)
      first_name.join("") + (array_name - first_name).collect{|a| a[0]}.join("")
    else
      first_name = array_name.last
      first_name + (array_name - [first_name]).collect{|a| a[0]}.join("")
    end
  end

  def find_trainer trainer_name
    trainer = User.where(type: ["admin", "trainer"]).each do |trainer|
      if convert_to_abbr(trainer.name) == trainer_name
        break trainer
      end
    end
    trainer.size > 1 ? nil : trainer
  end
end
