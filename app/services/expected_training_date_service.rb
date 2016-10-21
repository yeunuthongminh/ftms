class ExpectedTrainingDateService
  attr_reader :args

  def initialize args
    @course = args[:course]
  end

  def perform
    @course.load_trainees.includes(:profile).each do |trainee|
      trainee.profile.update_attributes finish_training_date: @course.end_date
    end
  end
end
