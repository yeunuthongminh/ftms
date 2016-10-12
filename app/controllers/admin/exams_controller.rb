class Admin::ExamsController < ApplicationController
  include FilterData
  authorize_resource only: :index
  before_action :load_filter, only: :index

  def index
    add_breadcrumb_index "exams"
    @exams = Exam.includes :user, user_subject: [course_subject: :subject]
    @filter_data_user = @filter_service.user_filter_data
    @exam_presenters = ExamPresenter.new(@exams, @namespace).render
  end
end
