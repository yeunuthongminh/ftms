class StatisticTotalTraineePresenter < ActionView::Base
  include Rails.application.routes.url_helpers

  def initialize total_trainees
    @total_trainees = total_trainees
  end

  def render
    sidebar = Array.new
    body = Array.new
    @total_trainees.each_with_index do |(sidebar_items, body_items), index|
      sidebar << sidebar_item(sidebar_items, index)
      body << body_item(body_items, index)
    end

    body << "<div></div>"
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
  def sidebar_item sidebar_items, index
    "<div class=\"trow list_#{index}\" id=\"sidebar-row-#{index}\">
      <div class=\"tcell stt\">#</div>
      <div class=\"tcell trainee_type\" title=\"#{user_type.name}\">
        #{user_type.name}
      </div>
      <div class=\"tcell programming_language\" title=\"#{language.name}\">
        #{language.name}
      </div>
    </div>"
  end

  def body_item body_items, index
    html = "<div class=\"trow list_#{index}\" id=\"body-row-#{index}\">"
    body_items.each do |month, value|
      html += "<div class=\"tcell total-trainees-month-#{month.gsub('/', '-')} trainee-by-month text-right\" data-total-trainees=\"#{value}\">
        #{value}
      </div>"
    end
    html += "</div>"
  end
end
