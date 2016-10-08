class Admin::TrainingManagementsController < ApplicationController
  load_and_authorize_resource class: false

  include FilterData

  before_action :load_filter, only: :index

  def index
    add_breadcrumb_index "training_managements"
    @filter_data_user = @filter_service.user_filter_data
    @users = User.trainees.includes(:trainer, :notes, user_subjects: [:course_subject],
      profile: [:status, :user_type, :location, :university, :programming_language]).order :name
    @training_management_presenters = TrainingManagementPresenter.new(@users, @namespace).render
  end
end
