module FilterData
  def load_filter
    filter_type = Filter.filter_types[params[:controller].split("/").last]

    target_params ||= nil

    @filter_service ||= FilterService.new filter_type, current_user,
      params[:id], target_params
  end
end
