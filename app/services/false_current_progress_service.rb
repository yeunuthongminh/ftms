class FalseCurrentProgressService
  def initialize course
    @course = course
  end

  def perform
    @course.user_subjects.update_all current_progress: false
  end
end
