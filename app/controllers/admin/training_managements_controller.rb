class Admin::TrainingManagementsController < ApplicationController
  include FilterData
  before_action :authorize
  before_action :load_filter, only: :index

  def index
    users = Trainee.includes(:trainer, user_subjects: [:course_subject],
      profile: [:status, :trainee_type, :location, :university, :language, :stage]).order :name
    @training_management_presenters = TrainingManagementPresenter.new(users, @namespace).render
  end
end
