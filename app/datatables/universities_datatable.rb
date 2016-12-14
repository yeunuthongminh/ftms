class UniversitiesDatatable
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
      iTotalRecords: University.count,
      iTotalDisplayRecords: universities.total_count,
      aaData: data
    }
  end

  private
  def data
    universities.map.each.with_index 1 do |university, index|
      [
        index,
        university.name,
        university.abbreviation,
        link_to(@view.t("buttons.edit"), eval("@view.edit_#{@namespace}_university_path(university)"),
          class: "text-primary pull-right"),
        link_to(@view.t("buttons.delete"), eval("@view.#{@namespace}_university_path(university)"),
          method: :delete, data: {confirm: @view.t("messages.delete.confirm")},
          class: "text-danger pull-right")
      ]
    end
  end

  def universities
    @universities ||= fetch_universities
  end

  def fetch_universities
    @universities = University.order "#{sort_column} #{sort_direction}"
    universities = @universities.per_page_kaminari(page).per per_page
    if params[:sSearch].present?
      universities = universities.where "name like :search", search: "%#{params[:sSearch]}%"
    end
    universities
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : @universities.size
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

  def can_edit university
    url = eval "@view.edit_#{@namespace}_university_path(university)"
    if policy url
      link_to @view.t("buttons.edit"), url, class: "text-primary pull-right"
    else
      ""
    end
  end

  def can_destroy university
    url = eval "@view.#{@namespace}_university_path(university)"
    if policy_with_method(url: url, action: "destroy")
      link_to @view.t("buttons.delete"), url, method: :delete,
        data: {confirm: @view.t("messages.delete.confirm")},
        class: "text-danger pull-right"
    else
      ""
    end
  end
end
