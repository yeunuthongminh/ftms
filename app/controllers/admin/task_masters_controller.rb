class Admin::TaskMastersController < ApplicationController

  def index
    @subject = Subject.includes(:documents, :task_masters)
      .find_by id: params[:subject_id]
    @task_masters = @subject.task_masters

    add_breadcrumb_path "subjects"
    add_breadcrumb @subject.name
    add_breadcrumb_subject_task_masters
  end
end
