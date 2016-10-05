module FilterData
  def load_filter
    filter_type = Filter.filter_types[params[:controller].to_sym]
    filter_type = Filter.filter_types[:assignees_histories] if
      params[:controller] == "assignees" && params[:project_id]

    selected_date = if params[:selected_date].blank?
      Date.today.beginning_of_month
    else
      Date.strptime(params[:selected_date], t("date.formats.year_month")).beginning_of_month
    end

    if params[:controller] == "projects" && params[:action] == "show"
      target_params = {selected_date: selected_date}.to_json
    end

    @filter_service ||= FilterService.new filter_type, current_user,
      params[:id] || params[:project_id], target_params
  end
end
