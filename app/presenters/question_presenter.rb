class QuestionPresenter < ActionView::Base
  include Rails.application.routes.url_helpers

  def initialize args
    @questions = args[:questions]
    @namespace = args[:namespace]
    @category = args[:category]
  end

  def render
    sidebar = Array.new
    body = Array.new
    @questions.each_with_index do |question, index|
      sidebar << sidebar_item(question, index)
      body << body_item(question, index)
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
  def sidebar_item question, index
    "<div class=\"trow list_#{index}\" id=\"sidebar-row-#{question.id}\">
      <div class=\"tcell stt\">#</div>
      <div class=\"tcell question_content\" title=\"#{question.content}\">
        #{sanitize question.content}
      </div>
    </div>
    "
  end

  def body_item question, index
    html = "<div class=\"trow #{"list_#{index}" }\" id=\"body-row-#{question.id}\">"

    unless @category
      html << "<div class=\"tcell category_name\" title=\"#{question.category_name}\">
          #{question.category_name}
        </div>"
    end

    html << "<div class=\"tcell level\" tite=\"#{question.level}\">
        #{t "questions.levels.#{question.level}"}
      </div>
      <div class=\"tcell action\">
        #{link_to t("buttons.edit"), eval("edit_#{@namespace}_question_path(question)")}
      </div>
    </div>"
  end
end
