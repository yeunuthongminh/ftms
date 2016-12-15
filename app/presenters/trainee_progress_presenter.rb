class TraineeProgressPresenter < ActionView::Base
  include Rails.application.routes.url_helpers
  include ApplicationHelper

  def initialize trainee_by_course
    @trainee_by_course = trainee_by_course
  end

  def render
    sidebar = Array.new
    body = Array.new
    @trainee_by_course.each_with_index do |items, index|
      sidebar << sidebar_item(items, index)
      body << body_item(items, index)
    end
    html =
      "<aside id=\"parent\" class=\"fixedTable-sidebar\">
      <div id=\"child\">
        <div id=\"table-sidebar\">
          <div class=\"tbody listsort filter_table_left_part\" id=\"list-records\">"
    html += sidebar.join("")
    html += "</div></div></div></aside>"
    html += "<div class=\"fixedTable-body tabel-scroll\">
      <div class=\"tbody listsort filter_table_right_part\">"
    html += body.join("")
    html += "</div></div>"
  end

  private
  def sidebar_item trainee, index
    html = "
      <div class=\"trow list_#{index}\" id=\"sidebar-row-#{index}\">
        <div class=\"tcell stt\">#</div>
        <div class=\"tcell staff_code\">
          #{trainee.profile.staff_code}
        </div>
        <div class=\"tcell trainee_name\" title=\"#{trainee.name}\">
          #{link_to trainee.name, eval("admin_user_path(trainee)")}
        </div>
      </div>"
  end

  def body_item trainee, index
    @supports = Supports::UserSupport.new trainee
    last_course = trainee.user_courses.course_progress.last
    html = "
      <div class=\"trow #{"list_#{index}"}\" id=\"body-row-#{trainee.id}\">"
    courses_html = ""
    title = ""
    if @supports.inprogress_course
      @supports.user_subjects.each do |user_subject|
        courses_html << "
          <div class=\"prog-bar-cont\">
          <div class=\"prog-bar\">"
        if user_subject.init?
          courses_html << "
            <div class=\"prog-bar-bg-init\"
              style=\"width: 100%;
              background-size: 100%\">
              #{user_subject.name}(#{user_subject.status})
            </div>
          </div>
        </div>"
        else
          if user_subject.finish?
            courses_html << "
              <div class=\"prog-bar-bg-finish\""
          elsif user_subject.waiting?
            courses_html << "
              <div class=\"prog-bar-bg-waiting\""
          else
            courses_html << "
              <div class=\"prog-bar-bg\""
          end
          courses_html << "
            <div class=\"prog-bar-bg-finish\"
                style=\"width:100%;
                background-size: 100%\">
                #{user_subject.name}(#{percentage_format user_subject.percent_progress} #{user_subject.status})
              </div>
            </div>
          </div>"
        end 
      end
    end
    html << "
      <div class=\"tcell trainee_type\" title=\"#{trainee.profile.trainee_type_name}\">
        #{trainee.profile.trainee_type_name}
      </div>
      <div class=\"tcell location\" title=\"#{trainee.profile.location_name}\">
        #{trainee.profile.location_name}
      </div>
      <div class=\"tcell trainee_status\" title=\"#{trainee.profile.status_name}\">
        #{trainee.profile.status_name}
      </div>

      <div class=\"tcell course_name\" title=\"#{last_course ? last_course.course_name : " "}\">
        #{last_course ? (link_to last_course.course_name, eval("admin_course_path(last_course)")) : ""}
      </div>
      <div class=\"tcell course\" title=\"#{title}\">
        <div class=\"list-progbar\">" << 
          courses_html << "
        </div>
      </div>
    </div>"
  end
end
