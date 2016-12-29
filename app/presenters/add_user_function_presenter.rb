class AddUserFunctionPresenter < ActionView::Base

  def initialize args
    @form = args[:form]
    @user_functions = args[:user_functions]
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
    else
      obj.prepend("Trainee")
    end
    "<div class=\"trow list_#{index}\" id=\"sidebar-row-#{function.model_class}\">
      <div class=\"tcell stt\">#</div>
      <div class=\"tcell name controller_name\" title=\"#{function.model_class}\">
        #{obj[0]} #{function.action} #{obj[1]}
      </div>
    </div>
    "
  end

  def body_item function, index
    html = "<div class=\"trow #{"list_#{index}"}\"
      id=\"body-row-#{function.model_class}\">"
    namespace = function.model_class.split("/")
    namespace[0] = "trainee" if namespace.size < 2
    unless Settings.user_functions.include? namespace[0]
      @form.fields_for :user_functions, @user_functions.build do |builder|
        Settings.user_functions.each do |fn|
          html += "
            #{builder.hidden_field :id, value:index}
            #{builder.hidden_field :type, value: "#{fn.humanize}Function"}
            #{builder.hidden_field :function_id, value: "#{function.id if function}"}
            <div class=\"tcell checked-function text-center\" title=\"#{function.action}\">
              #{builder.check_box :_destroy,
                {checked: find_function?(@form.object, function)}, false, true}
          </div>"
        end
      end
    end

    Settings.user_functions.each do |fn|
      if namespace[0] == fn
        @form.fields_for :user_functions, @user_functions.build do |builder|
          html += "
          #{builder.hidden_field :id, value:"#{index}"}
          #{builder.hidden_field :type, value: "#{fn.humanize}Function"}
          #{builder.hidden_field :function_id, value: "#{function.id if function}"}
          <div class=\"tcell checked-function text-center\" title=\"#{function.action}\">
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

  def find_function? user, function
    user.functions.has_function(function.model_class, function.action).any? if function
  end
end
