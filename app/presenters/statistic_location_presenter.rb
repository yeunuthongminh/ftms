class StatisticLocationPresenter < ActionView::Base
  def initialize trainee_by_location
    @trainee_by_location= trainee_by_location
  end

  def render
    sidebar = Array.new
    body = Array.new
    @trainee_by_location.each_with_index do |items, index|
      sidebar << sidebar_item(items, index)
      body << body_item(items, index)
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
      <div class=\"tcell location location-<%= sidebar_items[:name] %>\"
        title=\"sidebar_items[:name]}\">
        #{sidebar_items[:name]}
      </div>
    </div>"
  end

  def body_item body_items, index
    "<div class=\"trow list_#{index}\" id=\"body-row-#{index}\">
      <div class=\"tcell total-trainees-location-#{body_items[:name]}
        number_trainees text-right trainee-by-location\"
        data-total-trainees=\"#{body_items[:y]}\">
        #{body_items[:y]}
      </div>
    </div>"
  end
end
