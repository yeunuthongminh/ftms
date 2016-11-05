class ProgramsDatatable
  include AjaxDatatablesRails::Extensions::Kaminari

  delegate :params, :link_to, to: :@view

  def initialize view, namespace
    @namespace = namespace
    @view = view
  end

  def as_json options = {}
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: programs.size,
      iTotalDisplayRecords: programs.total_count,
      aaData: data
    }
  end

  private
  def data
    programs.map.each.with_index 1 do |program, index|
      [
        index,
        link_to(program.name,
          eval("@view.#{@namespace}_program_path(program)")),
        link_to(@view.t("buttons.edit"),
          eval("@view.edit_#{@namespace}_program_path(program)"),
          class: "pull-right")
      ]
    end
  end

  def programs
    @programs ||= fetch_programs
  end

  def fetch_programs
    @programs = Program.all
    programs = @programs.order("#{sort_column} #{sort_direction}")
      .per_page_kaminari(page).per per_page
    if params[:sSearch].present?
      programs = programs.where "programs.name like :search", search: "%#{params[:sSearch]}%"
    end
    programs
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : @programs.size
  end

  def sort_column
    columns = %w[id name]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
