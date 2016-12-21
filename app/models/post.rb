class Post < ApplicationRecord
  acts_as_paranoid
  acts_as_taggable
  acts_as_votable

  POST_ATTRIBUTES_PARAMS = [:title, :content, :tag_list]

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :daily_post_views, dependent: :destroy

  scope :most_viewed, ->{order views: :desc}
  scope :newest, ->{order created_at: :desc}
  scope :unanswered, -> do
    left_outer_joins(:comments).group(:id).having "COUNT(post_id) = 0"
  end
  scope :most_viewed_by, -> period do
    start_date = if period == "day"
      Date.today
    elsif period == "week"
      Date.today.last_week
    elsif period == "month"
      Date.today.last_month
    else
      Date.today.last_year
    end
    left_outer_joins(:daily_post_views).group(:id)
      .where("daily_post_views.created_at >= ?", start_date)
      .order "SUM(daily_post_views.views) DESC"
  end

  def today_post_views
    today_post_views = self.daily_post_views.where("created_at >= ?",
      Date.today).first || self.daily_post_views.create
  end
end
