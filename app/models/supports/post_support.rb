class Supports::PostSupport
  def initialize args = {}
    @params = args[:params]
    @post = args[:post]
    @user = args[:user]
    @comment = args[:comment]
    @filter_service = args[:filter_service]
    @search_params = args[:search_params]
  end

  def presenters
    PostPresenter.new(posts).render
  end

  %w(newest unanswered).each do |post_type|
    define_method "#{post_type}_posts" do
      page = @params[:tab] == post_type ? @params[:page] : nil
      unless instance_variable_get("@#{post_type}_posts")
        posts = if post_type == "newest"
          Post.order_desc :created_at
        else
          Post.send post_type
        end.ransack(@search_params).result(distinct: true)
        .includes(:taggings, :user)
        .per_page_kaminari(page).per Settings.faq.posts_per_page
        instance_variable_set "@#{post_type}_posts", posts
      end
      instance_variable_get "@#{post_type}_posts"
    end
  end

  %w(day week month).each do |period|
    define_method "most_viewed_posts_#{period}" do
      unless instance_variable_get("@most_viewed_posts_#{period}")
        posts = Post.most_viewed_by(period).includes(:taggings)
          .take Settings.faq.most_viewed_posts
        instance_variable_set("@most_viewed_posts_#{period}", posts)
      end
      instance_variable_get "@most_viewed_posts_#{period}"
    end
  end

  def load_answers
    @load_answers ||= @post.comments.roots.order_desc(:cached_votes_score)
      .includes(:user).per_page_kaminari(@params[:page])
      .per Settings.faq.answers_per_page
  end

  def load_replies answer
    answer.children.includes(:user).per_page_kaminari(@params[:page])
      .per Settings.faq.replies_per_page
  end

  def most_tagged_tags
    @most_tagged_tags ||= Post.tag_counts_on(:tags).order("COUNT DESC")
      .limit Settings.faq.most_tagged_tags
  end

  def related_posts
    @related_posts ||= @post.find_related_tags.order_desc(:cached_votes_score)
      .includes(:taggings).take Settings.faq.related_posts
  end

  def parent_comment
    parent_id = if @params[:comment]
      @params[:comment][:parent_id]
    else
      @params[:parent_id]
    end
    @parent_comment ||= @post.comments.find_by id: parent_id
  end

  def new_sub_comment
    @new_sub_comment ||= if parent_comment.root?
      parent_comment.children.build user: @user
    else
      parent_comment.parent.children.build user: @user
    end
  end

  def new_comment
    @new_comment ||= @post.comments.build user: @user
  end

  def filter_data_user
    @filter_data_user ||= @filter_service.user_filter_data
  end

  private
  def posts
    @posts ||= Post.includes(:user, :taggings).order_desc :created_at
  end
end
