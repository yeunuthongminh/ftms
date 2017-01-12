class Supports::StageSupport
  attr_reader :profile, :user_form

  def initialize args
    @profile = args[:profile]
    @stage = args[:stage]
    @user_form = args[:user_form]
  end

  def location_name
    @location ||= @user_form.location_name
  end

  def status
    @status ||= @user_form.status_name
  end

  def university
    @university ||= @user_form.university_name
  end

  def staff_code
    @staff_code ||= @user_form.staff_code
  end

  def stages
    @stages ||= Stage.all.map{|e| [e.name, e.id]}
  end

  def languages
    @languages ||= Language.all
  end

  def locations
    @locations ||= Location.all
  end

  def statuses
    @statuses ||= Status.all
  end

  def universities
    @universities ||= University.all
  end

  def trainee_types
    @trainee_types ||= TraineeType.all
  end
end
