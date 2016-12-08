class Supports::StageSupport
  attr_reader :profile, :user

  def initialize args
    @profile = args[:profile]
    @stage = args[:stage]
    @user = @profile.user
  end

  def location_name
    @location ||= @profile.location_name
  end

  def status
    @status ||= @profile.status_name
  end

  def university
    @university ||= @profile.university_name
  end

  def staff_code
    @staff_code ||= @profile.staff_code
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
