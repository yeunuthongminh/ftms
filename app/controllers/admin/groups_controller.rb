class Admin::GroupsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: :edit
  before_action :load_trainees_new, only: :new
  before_action :load_data_edit, only: :edit

  def new
    add_breadcrumb_path "groups"
    add_breadcrumb_new "groups"
  end

  def create
    if @group.save
      flash[:success] = flash_message "created"
      redirect_to admin_groups_path
    else
      load_trainees_new
      flash[:alert] = flash_message "not_created"
      render :new
    end
  end

  def edit
    add_breadcrumb_path "groups"
    add_breadcrumb_edit "groups"
  end

  def update
    if @group.update_attributes params_groups
      flash[:success] = flash_message "updated"
      redirect_to admin_groups_path
    else
      load_data_edit
      flash[:alert] = flash_message "not_updated"
      render :edit
    end
  end

  private
  def params_groups
    params.require(:group).permit Group::ATTRIBUTES_PARAMS
  end

  def load_trainees_new
    @trainees = User.trainees.free_group
      .includes user_subjects: [:course, course_subject: :subject]
  end

  def load_data_edit
    @group = Group.includes(group_users: :user).find_by id: params[:id]
    if @group.nil?
      flash[:alert] = flash_message "not_find"
      redirect_to admin_groups_path
    else
      @trainees = User.trainees.free_and_in_group(@group.id)
        .includes user_subjects: [:course, course_subject: :subject]
    end
  end
end
