module SynchronizeTrainingSchedule
  def synchronize_training_schedule title
    worksheet = @file.worksheet_by_title title
    worksheet.list.each do |line|
      trainee = User.find_by_name line[Settings.sync.training_schedules.name].strip

      start_training_date = get_date line[Settings.sync.training_schedules.start_training_date]
      leave_date = get_date line[Settings.sync.training_schedules.leave_date]
      finish_training_date = get_date line[Settings.sync.training_schedules.finish_training_date]
      graduation = get_date line[Settings.sync.training_schedules.graduation]
      trainee_type = find_object TraineeType, line[Settings.sync.training_schedules.trainee_type]
      university = find_object University, line[Settings.sync.training_schedules.university]
      language = find_object Language,
        line[Settings.sync.training_schedules.language]
      location = find_object Location, line[Settings.sync.training_schedules.location]
      working_day = line[Settings.sync.training_schedules.working_day]
      staff_code = line[Settings.sync.training_schedules.staff_code]
      join_div_date = line[Settings.sync.training_schedules.join_div_date]
      status = find_status line[Settings.sync.training_schedules.status].strip
      stage = find_stage status
      ready_for_project = get_date line[Settings.sync.training_schedules.ready_for_project]

      if trainee
        trainee.profile.leave_date ||= leave_date
        trainee.profile.finish_training_date ||= finish_training_date
        trainee.profile.graduation ||= graduation
        trainee.profile.trainee_type ||= trainee_type
        trainee.profile.university ||= university
        trainee.profile.language ||= language
        trainee.profile.location ||= location
        trainee.profile.working_day ||= working_day
        trainee.profile.staff_code ||= staff_code
        trainee.profile.join_div_date ||= join_div_date
        trainee.profile.status ||= status
        trainee.profile.stage ||= stage
        trainee.profile.ready_for_project ||= ready_for_project
        trainee.trainer_id ||= trainer_id
      else
        name = line[Settings.sync.training_schedules.name].strip
        email = convert_to_email name

        trainee = Trainee.new name: line[Settings.sync.training_schedules.name],
          email: email, trainer_id: trainer_id
        trainee.build_profile start_training_date: start_training_date,
          leave_date: leave_date,
          finish_training_date: finish_training_date,
          graduation: graduation,
          trainee_type: trainee_type,
          university: university,
          language: language,
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

      trainee.try :save!
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
      Status.find_by name: "Resigned"
    end
  end

  def find_stage status
    return if status.nil?
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
      Stage.find_or_create_by name: "Away"
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

  def trainer_id
    User.find_by(email: "nguyen.binh.dieu@framgia.com").id
  end
end
