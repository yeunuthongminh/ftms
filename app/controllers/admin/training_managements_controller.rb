class Admin::TrainingManagementsController < ApplicationController
  load_and_authorize_resource class: false

  def index
    add_breadcrumb_index "training_managements"
    @users = User.trainees.includes :trainer, :notes, user_subjects: [:course_subject],
      profile: [:status, :user_type, :location, :university, :programming_language]
    @training_management_presenters = TrainingManagementPresenter.new(@users).render
  end
end
