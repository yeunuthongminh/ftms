class Admin::TrainingManagementsController < ApplicationController
  load_and_authorize_resource class: false

  include FilterData

  before_action :load_filter, only: :index

  def index
    add_breadcrumb_index "training_managements"
    users = User.includes(:trainer, user_subjects: [:course_subject],
      profile: [:status, :user_type, :location, :university, :programming_language, :stage]).order :name
    @training_management_presenters = TrainingManagementPresenter.new(users, @namespace).render
  end
end
