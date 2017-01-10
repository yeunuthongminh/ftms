class Supports::TagSupport
  def initialize args = {}
    @params = args[:params]
  end

  %w(newest unanswered).each do |post_type|
    define_method "#{post_type}_posts" do
      page = @params[:tab] == post_type ? @params[:page] : nil
      unless instance_variable_get("@#{post_type}_posts")
        posts = if post_type == "newest"
          Post.order_desc :created_at
        else
          Post.send post_type
        end.tagged_with(@params[:id]).includes(:taggings, :user)
        .per_page_kaminari(page).per Settings.qna.posts_per_page
        instance_variable_set "@#{post_type}_posts", posts
      end
      instance_variable_get "@#{post_type}_posts"
    end
  end

  %w(day week month).each do |period|
    define_method "most_viewed_posts_#{period}" do
      unless instance_variable_get("@most_viewed_posts_#{period}")
        posts = Post.most_viewed_by(period).tagged_with(@params[:id])
          .includes(:taggings).take Settings.qna.most_viewed_posts
        instance_variable_set("@most_viewed_posts_#{period}", posts)
      end
      instance_variable_get "@most_viewed_posts_#{period}"
    end
  end

  def most_tagged_tags
    @most_tagged_tags ||= Post.tag_counts_on(:tags).order("COUNT DESC")
      .limit Settings.qna.most_tagged_tags
  end
end
