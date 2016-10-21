class QuestionsDatatable
  include AjaxDatatablesRails::Extensions::Kaminari

  delegate :params, :link_to, to: :@view

  def initialize view, namespace
    @namespace = namespace
    @view = view
  end

  def as_json options = {}
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: questions.size,
      iTotalDisplayRecords: questions.total_count,
      aaData: data
    }
  end

  private
  def data
    questions.includes(:subject).map.each.with_index 1 do |question, index|
      [
        index,
        link_to(question.content,
          eval("@view.#{@namespace}_question_path(question)")),
        I18n.t("questions.level.#{question.level}"),
        link_to(question.subject_name,
          eval("@view.#{@namespace}_subject_task_masters_path(question.subject)")),
        link_to(@view.t("buttons.edit"),
          eval("@view.edit_#{@namespace}_question_path(question)"),
          class: "pull-right"),
        link_to(@view.t("buttons.delete"),
          eval("@view.#{@namespace}_question_path(question)"),
          method: :delete, data: {confirm: @view.t("messages.delete.confirm")},
          class: "text-danger pull-right")
      ]
    end
  end

  def questions
    @questions ||= fetch_questions
  end

  def fetch_questions
    @questions = Question.all
    questions = @questions.order("#{sort_column} #{sort_direction}")
      .per_page_kaminari(page).per per_page
    if params[:sSearch].present?
      questions = questions.where "questions.content like :search", search: "%#{params[:sSearch]}%"
    end
    questions
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : @questions.size
  end

  def sort_column
    columns = %w[id content level subject_id]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
