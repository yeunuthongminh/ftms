class AllocateFunctionPresenter < ActionView::Base
  include Rails.application.routes.url_helpers

  def initialize args
    @namespace = args[:namespace]
    @role = args[:role]
    @form = args[:form]
  end

  def render
    sidebar = Array.new
    body = Array.new
    Function.all.each_with_index do |function, index|
      sidebar << sidebar_item(function, index)
      body << body_item(function, index)
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
  def sidebar_item function, index
    obj = function.model_class.split("/")
    if obj.length == 2
      obj[0] = obj[0].capitalize
      obj[1] = obj[1].capitalize
      "<div class=\"trow list_#{index}\" id=\"sidebar-row-#{function.model_class}\">
        <div class=\"tcell stt\">#</div>
        <div class=\"tcell namespace\">
          #{obj[0]}
        </div>
        <div class=\"tcell name controller_name\" title=\"#{function.model_class}\">
          #{obj[0]} #{function.action} #{obj[1]}
        </div>
      </div>
      "
    else
      "<div class=\"trow list_#{index}\" id=\"sidebar-row-#{function.model_class}\">
        <div class=\"tcell stt\">#</div>
        <div class=\"tcell namespace\">
        </div>
        <div class=\"tcell name controller_name\" title=\"#{function.model_class}\">
          Trainee #{function.action} #{obj[0]}
        </div>
      </div>
      "
    end
  end

  def body_item function, index
    html = "<div class=\"trow #{"list_#{index}"}\"
      id=\"body-row-#{function.model_class}\">
      "
    namespace = function.model_class.split("/")
    namespace[0] = "trainee" if namespace.size < 2
    unless Settings.user_functions.include? namespace[0]
      @form.fields_for :role_functions, @role.functions.build do |builder|
        Settings.user_functions.each do |fn|
          html += "
            #{builder.hidden_field :role_id, value: "#{@role.id}"}
            #{builder.hidden_field :function_id,
              value: "#{function.id if function}"}
            <div class=\"tcell checked-function text-center\"
              title=\"#{function.action}\">
              #{builder.check_box :_destroy,
                {checked: find_function?(@form.object, function)}, false, true}
          </div>"
        end
      end
    end

    Settings.user_functions.each do |fn|
      if namespace[0] == fn
        @form.fields_for :role_functions, @role.functions.build do |builder|
          html += "
            #{builder.hidden_field :role_id, value: "#{@role.id}"}
            #{builder.hidden_field :function_id,
              value: "#{function.id if function}"}
            <div class=\"tcell checked-function text-center\"
              title=\"#{function.action}\">
              #{builder.check_box :_destroy,
                {checked: find_function?(@form.object, function)}, false, true}
            </div>"
        end
      else
        html += "<div class=\"tcell checked-function text-center\"
          title=\"#{function.action}\"></div>"
      end
    end
    html += "</div>"
  end

  def find_function? role, function
    role.functions.has_function(function.model_class, function.action).any? if function
  end
end
