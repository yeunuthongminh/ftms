class RolesDatatable
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
      iTotalRecords: Role.count,
      iTotalDisplayRecords: roles.total_count,
      aaData: data
    }
  end

  private
  def data
    roles.map.each.with_index 1 do |role, index|
      [
        index,
        role.name,
        can_edit(role),
        can_delete(role)
      ]
    end
  end

  def roles
    @roles ||= fetch_roles
  end

  def fetch_roles
    @roles = Role.not_admin.order "#{sort_column} #{sort_direction}"
    roles = @roles.per_page_kaminari(page).per per_page
    if params[:sSearch].present?
      roles = roles.where "name like :search", search: "%#{params[:sSearch]}%"
    end
    roles
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : @roles.size
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

  def can_edit role
    if policy(controller: "roles", action: "edit")
      link_to @view.t("buttons.edit"), eval("@view.edit_#{@namespace}_role_path(role)"),
        class: "text-primary pull-right"
    else
      ""
    end
  end

  def can_delete role
    if policy(controller: "roles", action: "destroy")
      link_to @view.t("buttons.delete"), eval("@view.#{@namespace}_role_path(role)"),
        method: :delete, data: {confirm: @view.t("messages.delete.confirm")},
        class: "text-danger pull-right"
    else
      ""
    end
  end
end
