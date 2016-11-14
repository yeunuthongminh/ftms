class AllocateFunctionPresenter < ActionView::Base
  include Rails.application.routes.url_helpers

  def initialize args
    @routes = args[:routes]
    @namespace = args[:namespace]
    @role = args[:role]
  end

  def render
    sidebar = Array.new
    body = Array.new
    @routes.each_with_index do |route, index|
      sidebar << sidebar_item(route, index)
      body << body_item(route, index)
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
  def sidebar_item route, index
    "<div class=\"trow list_#{index}\" id=\"sidebar-row-#{route[:controller]}\">
      <div class=\"tcell stt\">#</div>
      <div class=\"tcell name controller_name\" title=\"#{route[:controller]}\">
        #{route[:controller]}
      </div>
    </div>
    "
  end

  def body_item route, index
    html = "<div class=\"trow #{"list_#{index}" }\"
      id=\"body-row-#{route[:controller]}\">"
    Settings.all_functions.each do |function|
      if route[:actions].include? function
        @role.fields_for :functions, @role.object.functions.build do |builder|
          html += "#{builder.hidden_field :id,
            value: @role.object.decorate.function(function, route[:controller])}
          #{builder.hidden_field :model_class, value: route[:controller]}
          #{builder.hidden_field :action, value: function}
          <div class=\"tcell #{function}-function text-center\"
            title=\"#{function}\">
            #{builder.check_box :_destroy, {checked: @role.object.decorate
              .function(function, route[:controller]).present?}, false, true}
          </div>"
        end
      else
        html += "<div class=\"tcell #{function}-function text-center\"
          title=\"#{function}\"></div>"
      end
    end
    html += "</div>"
  end
end
