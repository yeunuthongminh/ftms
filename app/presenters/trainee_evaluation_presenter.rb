class TraineeEvaluationPresenter < ActionView::Base
  include Rails.application.routes.url_helpers

  def initialize args
    @trainee_evaluations = args[:trainee_evaluations]
    @namespace = args[:namespace]
    @current_user = args[:current_user]
  end

  def render
    sidebar = Array.new
    body = Array.new
    @trainee_evaluations.each_with_index do |trainee_evaluation, index|
      sidebar << sidebar_item(trainee_evaluation, index)
      body << body_item(trainee_evaluation, index)
    end
    html = "<aside id=\"parent\" class=\"fixedTable-sidebar\">
      <div id=\"child\">
        <div id=\"table-sidebar\">
          <div class=\"tbody listsort filter_table_left_part\" id=\"list-records\">
    "
    html += sidebar.join("")
    html += "</div></div></div></aside>"

    html += "<div class=\"fixedTable-body tabel-scroll\">
      <div class=\"tbody listsort filter_table_right_part\">"
    html += body.join("")
    html += "</div></div>"
  end

  private
  def sidebar_item trainee_evaluation, index
    "<div class=\"trow list_#{index}\" id=\"sidebar-row-#{trainee_evaluation.id}\">
      <div class=\"tcell stt\">#</div>
      <div class=\"tcell name trainee_name\"
        title=\"#{trainee_evaluation.user_name}\">
        #{link_to trainee_evaluation.user_name,
          eval("#{@namespace}_user_path(trainee_evaluation.user)")}
      </div>
    </div>
    "
  end

  def body_item trainee_evaluation, index
    html = "<div class=\"trow list_#{index}\"
      id=\"body-row-#{trainee_evaluation.id}\">
      <div class=\"tcell course_name\"
        title=\"#{trainee_evaluation.targetable.course_name if
        trainee_evaluation.targetable_type == TraineeCourse.name}\">
        #{link_to_course trainee_evaluation}
      </div>
      <div class=\"tcell subject_name\"
        title=\"#{trainee_evaluation.targetable.subject_name if
        trainee_evaluation.targetable_type == UserSubject.name}\">
        #{link_to_course_subject trainee_evaluation}
      </div>
      <div class=\"tcell total_point\" title=\"#{trainee_evaluation.total_point}\">
        #{trainee_evaluation.total_point}
      </div>
      <div class=\"tcell action text-right\">
        #{link_evaluate trainee_evaluation}
      </div>
      <div class=\"tcell blank\"></div></div>"
  end

  def link_evaluate trainee_evaluation
    link_to t("subjects.fields.evaluate"),
      [:edit, @namespace.to_sym, trainee_evaluation.targetable,
      trainee_evaluation]
  end

  def link_to_course trainee_evaluation
    link_to trainee_evaluation.targetable.course_name,
      [@namespace.to_sym, trainee_evaluation.targetable.course] if
      trainee_evaluation.targetable_type == TraineeCourse.name
  end

  def link_to_course_subject trainee_evaluation
    link_to trainee_evaluation.targetable.subject_name,
      [@namespace.to_sym, trainee_evaluation.targetable.course,
      trainee_evaluation.targetable.subject] if
      trainee_evaluation.targetable_type == UserSubject.name
  end
end
