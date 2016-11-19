class CoursePresenter < ActionView::Base
  include Rails.application.routes.url_helpers

  def initialize args
    @courses = args[:courses]
    @namespace = args[:namespace]
    @program = args[:program]
  end

  def render
    sidebar = Array.new
    body = Array.new
    @courses.each_with_index do |course, index|
      sidebar << sidebar_item(course, index)
      body << body_item(course, index)
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
  def sidebar_item course, index
    "<div class=\"trow list_#{index}\" id=\"sidebar-row-#{course.id}\">
      <div class=\"tcell stt\">#</div>
      <div class=\"tcell name course_name\" title=\"#{course.name}\">
      #{link_to course.name, eval("#{@namespace}_course_path(course)")}
      </div>
    </div>
    "
  end

  def body_item course, index
    html = "<div class=\"trow list_#{index}\" id=\"body-row-#{course.id}\">
      <div class=\"tcell course_trainers\">
        #{course_trainers course}
      </div>
      <div class=\"tcell program #{"hidden" if @program}\">
        #{course.program_name}
      </div>
      <div class=\"tcell programming_language\" title=\"#{course.programming_language_name}\">
        #{course.programming_language_name}
      </div>
      <div class=\"tcell location\" title=\"#{course.location_name}\">
        #{course.location_name}
      </div>
      <div class=\"tcell course_status text-center\">
        #{course.decorate.set_status}
      </div>
      <div class=\"tcell course_start_date text-right\">
        #{l course.start_date, format: :default if course.start_date}
      </div>
      <div class=\"tcell course_end_date text-right\">
        #{l course.end_date, format: :default if course.end_date}
      </div></div>"
  end

  def course_trainers course
    course.load_trainers.map do |trainer|
      link_to trainer.name, eval("#{@namespace}_user_path(trainer)"),
        title: trainer.name
    end.join(", ")
  end
end
