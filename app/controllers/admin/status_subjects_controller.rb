class Admin::StatusSubjectsController < ApplicationController
  before_action :authorize
  before_action :load_data

  def update
    @supports.user_subjects.update_all_status params[:status], current_user,
      @supports.course_subject
    respond_to do |format|
      format.js {render template: "admin/user_subjects/update.js.erb"}
    end
  end

  private
  def load_data
    @supports = Supports::UserSubject.new user_subject: @user_subject,
      course_subject_id: params[:course_subject_id]
    redirect_if_object_nil @supports.course_subject
  end
end

