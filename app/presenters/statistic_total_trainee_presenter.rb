class StatisticTotalTraineePresenter < ActionView::Base
  include Rails.application.routes.url_helpers

  def initialize total_trainees, months
    @total_trainees = total_trainees
    @months = months
  end

  def render
    sidebar = Array.new
    body = Array.new
    @total_trainees.each_with_index do |(user_type, languages), user_type_index|
      languages.each_with_index do |(language, months), language_index|
        sidebar << sidebar_item(user_type, language, user_type_index, language_index)
        body << body_item(user_type, language, months, user_type_index, language_index)
      end
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
  def sidebar_item user_type, language, user_type_index, language_index
    "<div class=\"trow list_#{user_type_index}_#{language_index}\" id=\"sidebar-row-#{user_type.id}-#{language.id}\">
      <div class=\"tcell stt\">#</div>
      <div class=\"tcell trainee_type\" title=\"#{user_type.name}\">
        #{link_to user_type.name, admin_user_type_path(user_type)}
      </div>
      <div class=\"tcell programming_language\" title=\"#{language.name}\">
        #{link_to language.name, admin_programming_language_path(language)}
      </div>
    </div>"
  end

  def body_item user_type, language, months, user_type_index, language_index
    html = "<div class=\"trow list_#{user_type_index}_#{language_index}\" id=\"body-row-#{user_type.id}-#{language.id}\">"
    months.each do |month, value|
      html += "<div class=\"tcell total-trainees-month-#{month.gsub('/', '-')} trainee-by-month text-right\" data-total-trainees=\"#{value}\">
        #{value}
      </div>"
    end
    html += "</div>"
  end
end
