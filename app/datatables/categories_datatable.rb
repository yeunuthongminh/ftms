class CategoriesDatatable
  include AjaxDatatablesRails::Extensions::Kaminari
  include Pundit
  include PolicyHelper

  delegate :params, :link_to, to: :@view

  def initialize view, namespace, current_user
    @namespace = namespace
    @view = view
    @current_user = current_user
  end

  def as_json options = {}
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: categories.count,
      iTotalDisplayRecords: categories.total_count,
      aaData: data
    }
  end

  private
  def data
    categories.map.each.with_index 1 do |category, index|
      [
        index,
        can_view(category),
        category.language_name,
        can_edit(category),
        can_delete(category)
      ]
    end
  end

  def categories
    @categories ||= fetch_categories
  end

  def fetch_categories
    column_info = sort_column.split "."

    @categories = if column_info[1]
      Category.left_outer_joins(:language).order "#{sort_column} #{sort_direction}"
    else
      Category.order "#{sort_column} #{sort_direction}"
    end

    categories = @categories.per_page_kaminari(page).per per_page
    if params[:sSearch].present?
      categories = categories.where "name like :search",
        search: "%#{params[:sSearch]}%"
    end
    categories
  end

  def page
    params[:iDisplayStart].to_i / per_page + 1
  end

  def per_page
    if params[:iDisplayLength].to_i > 0
      params[:iDisplayLength].to_i
    else
      @categories.size
    end
  end

  def sort_column
    columns = %w[id name languages.name]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def current_user
    @current_user
  end

  def can_view category
    if policy(controller: "categories", action: "show")
      link_to category.name, eval("@view.#{@namespace}_category_path(category)")
    else
      ""
    end
  end

  def can_edit category
    if policy(controller: "categories", action: "edit")
      link_to @view.t("buttons.edit"),
        eval("@view.edit_#{@namespace}_category_path(category)"),
        class: "text-primary pull-right edit_category", remote: true
    else
      ""
    end
  end

  def can_delete category
    if policy(controller: "categories", action: "destroy")
      link_to @view.t("buttons.delete"),
        eval("@view.#{@namespace}_category_path(category)"),
        method: :delete, data: {confirm: @view.t("messages.delete.confirm")},
        class: "text-danger pull-right", remote: true
    else
      ""
    end
  end
end
