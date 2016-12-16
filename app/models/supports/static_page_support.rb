class Supports::StaticPageSupport
  def initialize args = {}
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

  def most_viewed_posts
    @most_viewed_posts ||= Post.most_viewed.take Settings.static_pages.num_of_faq
  end
end
