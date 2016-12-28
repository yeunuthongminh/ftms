module LikesHelper
  def create_like target
    @like = target.likes.find_or_initialize_by user_id: current_user.id
  end
end
