class EvaluationStandardsDatatable
  include AjaxDatatablesRails::Extensions::Kaminari

  delegate :params, :link_to, to: :@view

  def initialize view, namespace
    @namespace = namespace
    @view = view
  end

  def as_json options = {}
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: EvaluationStandard.count,
      iTotalDisplayRecords: evaluation_standards.total_count,
      aaData: data
    }
  end

  private
  def data
    evaluation_standards.map.each.with_index 1 do |evaluation_standard, index|
      [
        index,
        evaluation_standard.name,
        evaluation_standard.min_point,
        evaluation_standard.max_point,
        link_to(@view.t("buttons.edit"),
          eval("@view.edit_#{@namespace}_evaluation_standard_path(evaluation_standard)"),
          class: "text-primary pull-right"),
        link_to(@view.t("buttons.delete"),
          eval("@view.#{@namespace}_evaluation_standard_path(evaluation_standard)"),
          method: :delete, data: {confirm: @view.t("messages.delete.confirm")},
          class: "text-danger pull-right")
      ]
    end
  end

  def evaluation_standards
    @evaluation_standards ||= fetch_evaluation_standards
  end

  def fetch_evaluation_standards
    @evaluation_standards = EvaluationStandard.order "#{sort_column} #{sort_direction}"
    evaluation_standards = @evaluation_standards.per_page_kaminari(page).per per_page
    if params[:sSearch].present?
      evaluation_standards = evaluation_standards.where "name like :search", search: "%#{params[:sSearch]}%"
    end
    evaluation_standards
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : @evaluation_standards.size
  end

  def sort_column
    columns = %w[id name]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
