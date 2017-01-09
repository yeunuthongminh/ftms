class AllocateFunctionPresenter < ActionView::Base
  include Rails.application.routes.url_helpers

  def initialize args
    @functions = Function.all
    @routes = routes
    @namespace = args[:namespace]
    @role = args[:role]
    @form = args[:form]
  end

  def render
    sidebar_admin = Array.new
    body_admin = Array.new
    @routes.each_with_index do |route, index|
      sidebar_admin << sidebar_item(route, index)
      body_admin << body_item(route, index)
    end
    html = "<aside id=\"parent\" class=\"fixedTable-sidebar\">
      <div id=\"child\">
        <div id=\"table-sidebar\">
          <div class=\"tbody listsort filter_table_left_part\" id=\"list-records\">
    "
    html += sidebar_admin.join("")
    html += "</div></div></div></aside>"

    html += "<div class=\"fixedTable-body tabel-scroll\">
      <div class=\"tbody listsort filter_table_right_part\">"
    html += body_admin.join("")
    html += "</div></div>"
  end

  def routes
    routes = []
    @functions.map(&:model_class).uniq.each do |controller|
      routes << Hash[:controller, controller, :actions,
        Function.select{|function| function.model_class == controller}.pluck(:action).uniq]
    end
    routes
  end

  private
  def sidebar_item route, index
    "<div class=\"trow list_#{index}\" id=\"sidebar-row-#{route[:controller]}\"
      class=\"#{route[:controller].split("/").first}\">
      <div class=\"tcell stt\">#</div>
      <div class=\"tcell name controller_name\" title=\"#{route[:controller]}\">
        #{route[:controller]}
      </div>
      <input type=\"hidden\" name=\"role[function_ids][]\">
    </div>
    "
  end

  def body_item route, index
    html = "<div class=\"trow #{"list_#{index}"} trow-items\"
      id=\"body-row-#{route[:controller]}\">"
    Settings.functions.each do |function|
      if route[:actions].include? function
        a = find_function(function, route[:controller])
        html += " <div class=\"tcell #{function}-function text-center\" title=\"#{function}\">"
        if @role.functions.ids.include? a
          html += "<input type =\"checkbox\" name=\"role[function_ids][]\"
            id=\"role_function_ids_#{a}\" value=\"#{a}\" checked >"
        else
        html += "<input type =\"checkbox\" name=\"role[function_ids][]\"
          id=\"role_function_ids_#{a}\" value=\"#{a}\" >"
        end
        html+= "</div>"
      else
        html += "<div class=\"tcell function text-center\"
          title=\"#{function}\"></div>"
      end
    end
    html += "<div class=\"tcell text-center\">
      <input type=\"checkbox\" data-parent=\"#{index}\" class=\"sltAll\"></input></div>
    </div>"
  end

  def find_function action, model_class
    function = @role.functions.find {|function| function.model_class == model_class &&
      function.action == action if function}
    function.present? ? function.id : nil
  end
end


