class FilterService
  def initialize filter_type, user, target_id, target_params
    @filter_type, @user, @target_id, @target_params = filter_type, user, target_id, target_params
    @user_filter ||= user_filter
  end

  def user_filter_data
    @user_filter.try :content
  end

  def is_on?
    @user_filter.is_turn_on? rescue true
  end

  private
  def user_filter
    @user.filters.find_by filter_type: @filter_type, target_id: @target_id, target_params: @target_params
  end
end
