class LocationsDatatable
  include AjaxDatatablesRails::Extensions::Kaminari
  include Pundit
  include PolicyHelper

  delegate :params, :link_to, to: :@view

  def initialize view, namespace, current_user
    @view = view
    @namespace = namespace
    @current_user = current_user
  end

  def as_json options = {}
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Location.count,
      iTotalDisplayRecords: locations.total_count,
      aaData: data
    }
  end

  private
  def data
    locations.includes(:manager).map.each.with_index 1 do |location, index|
      manager = location.manager
      [
        index,
        link_to(location.name, eval("@view.#{@namespace}_location_path(location)")),
        if location.manager.present?
          link_to(@view.avatar_user_tag(manager, "profile-user img-circle",
            Settings.image_size_20), eval("@view.#{@namespace}_user_path(manager)"),
            title: manager.name)
        end,
        can_update(location),
        can_delete(location)
      ]
    end
  end

  def locations
    @locations ||= fetch_locations
  end

  def fetch_locations
    @locations = Location.order "#{sort_column} #{sort_direction}"
    locations = @locations.per_page_kaminari(page).per per_page
    if params[:sSearch].present?
      locations = locations.where "name like :search", search: "%#{params[:sSearch]}%"
    end
    locations
  end

  def page
    params[:iDisplayStart].to_i / per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : @locations.size
  end

  def sort_column
    columns = %w[id name]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def current_user
    @current_user
  end

  def can_update location
    url = eval "@view.edit_#{@namespace}_location_path(location)"
    if policy url
      link_to @view.t("buttons.edit"), url, class: "text-primary pull-right"
    else
      ""
    end
  end

  def can_delete location
    url = eval "@view.#{@namespace}_location_path(location)"
    if policy_with_method(url: url, action: "destroy")
      link_to @view.t("buttons.delete"), url, method: :delete,
        data: {confirm: @view.t("messages.delete.confirm")},
        class: "text-danger pull-right"
    else
      ""
    end
  end
end
