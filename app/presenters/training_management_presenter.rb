class TrainingManagementPresenter < ActionView::Base
  include Rails.application.routes.url_helpers

  def initialize users
    @users = users
  end

  def render
    sidebar = Array.new
    body = Array.new
    @users.each_with_index do |user, index|
      sidebar << sidebar_item(user, index)
      body << body_item(user, index)
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
  def sidebar_item user, index
    "<div class=\"trow list_#{index}\" id=\"sidebar-row-#{user.id}\">
      <div class=\"tcell stt\">#</div>
      <div class=\"tcell name employee_name\" title=\"#{user.name}\">
      #{link_to user.name, admin_user_path(id: user.id)}
      </div>
    </div>
    "
  end

  def body_item user, index
    html = "<div class=\"trow #{"list_#{index}" }\" id=\"body-row-#{user.id}\">
      <div class=\"tcell trainee_type\" data-toogle=\"tooltip\" title=#{user.profile.user_type_name}>
        #{user.profile.user_type_name}
      </div>
      <div class=\"tcell location division\" data-toogle=\"tooltip\" title=#{user.profile.location_name}>
        #{user.profile.location_name}
      </div>
      <div class=\"tcell status text-center\" data-toogle=\"tooltip\" title=#{user.profile.status_name}>
        #{user.profile.status_name}
      </div>
      <div class=\"tcell university\" data-toogle=\"tooltip\" title=#{user.profile.university_name}>
        #{user.profile.university_name}
      </div>
      <div class=\"tcell graduation skill_name\">
      #{l user.profile_graduation, format: :year_month if user.profile_graduation}
      </div>
      <div class=\"tcell programming_language evaluation_rank_value \" data-toogle=\"tooltip\" title=#{user.profile.programming_language_name}>
        #{user.profile.programming_language_name}
      </div>
      <div class=\"tcell start_training_date text-right\">
        #{l user.profile.start_training_date, format: :default if user.profile.start_training_date}
      </div>
      <div class=\"tcell leave_date text-right\">
        #{l user.profile.leave_date, format: :default if user.profile.leave_date}
      </div>
      <div class=\"tcell finish_training_date text-right\">
        #{l user.profile.finish_training_date, format: :default if user.profile.finish_training_date}
      </div>
      <div class=\"tcell ready_for_project text-center\">
        #{user.profile.ready_for_project? ? t("profiles.columns.ready_for_project.ready") :
          t("profiles.columns.ready_for_project.not_ready")}
      </div>
      <div class=\"tcell contract_date text-right\">
        #{l user.profile.contract_date, format: :default if user.profile.contract_date}
      </div>
      <div class=\"tcell working_day text-right\">
        #{user.profile_working_day}
      </div>
      <div class=\"tcell trainer\">
        #{link_to(user.trainer.name, admin_user_path(user.trainer),
          title: user.trainer.name) if user.trainer}
      </div>
      <div class=\"tcell current_progress\">
        #{(subject = user.user_subjects.find{|s| s.current_progress}) ? subject.name : ""}
      </div>
      <div class=\"tcell note\">
        #{user.notes.any? ? user.notes.last.name : ""}
      </div>"
    html += "<div class=\"tcell action\">
      #{link_to t("button.edit"), edit_admin_user_path(user)}
      </div></div>"
  end
end
