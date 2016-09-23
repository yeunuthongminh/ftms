class TrainingManagementsDatatable
  include AjaxDatatablesRails::Extensions::Kaminari

  delegate :params, :link_to, to: :@view

  def initialize view, namespace
    @view = view
    @namespace = namespace
  end

  def as_json options = {}
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: users.total_count,
      iTotalDisplayRecords: users.total_count,
      aaData: data
    }
  end

  private
  def data
    users.map.each do |user|
      [
        link_to(user.name, eval("@view.#{@namespace}_user_path(user)")),
        user.profile.user_type_name,
        user.profile.location_name,
        user.profile.status_name,
        user.profile.university_name,
        user.profile_graduation,
        user.profile_working_day,
        user.profile.programming_language_name,
        user.profile.start_training_date,
        user.profile.leave_date,
        user.profile.finish_training_date,
        user.profile.ready_for_project? ? I18n.t("profiles.columns.ready_for_project.ready") :
          I18n.t("profiles.columns.ready_for_project.not_ready"),
        user.profile.contract_date,
        "",
        user.trainer ? user.trainer.name : "",
        (subject = user.user_subjects.find{|s| s.current_progress}) ? subject.name : "",
        user.notes.any? ? user.notes.last.name : ""
      ]
    end
  end

  def users
    @users ||= fetch_users
  end

  def fetch_users
    @users = User.trainees.includes :trainer, :notes, user_subjects: [:course_subject],
      profile: [:status, :user_type, :location, :university, :programming_language]
    users = @users.order("#{sort_column} #{sort_direction}")
      .where("users.name like :search", search: "%#{params[:sSearch]}%")
      .per_page_kaminari(page).per per_page

    # if params[:sSearch].present?
    #   users = users.where "users.name like :search", search: "%#{params[:sSearch]}%"
    # end
    users
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : @users.size
  end

  def sort_column
    columns = %w[id name]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
