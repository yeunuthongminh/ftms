class ExamsController < ApplicationController
  authorize_resource only: :show
  before_action :find_exam, only: :show

  def show
  end

  private
  def find_exam
    @exam = Exam.includes(results: [:answer, question: :answers])
      .find_by id: params[:id]
    if @exam.nil?
      flash[:alert] = flash_message "not_find"
      redirect_to root_path
    end
  end
end
