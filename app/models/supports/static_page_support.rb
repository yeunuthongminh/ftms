class Supports::StaticPageSupport
  def initialize
  end

  def trainees_size
    @trainees_size ||= Trainee.count
  end

  def trainers_size
    @trainers_size ||= Trainer.count
  end

  def courses_size
    @courses_size ||= Course.count
  end

  def languages
    @languages ||= Language.order_by_trainee
      .take Settings.static_pages.num_of_languages
  end
end
