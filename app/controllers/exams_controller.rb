class ExamsController < ApplicationController
  authorize_resource only: :show
  before_action :find_exam, only: [:show, :update]

  def show
    check_status
    @remaining_time = @exam.remaining_time
  end

  def update
    if @exam.update_attributes exam_params
      flash[:success] = t "exams.updated"
      @exam.finish!
    else
      flash[:danger] = t "exams.update_fail"
    end
    redirect_to [@exam.user_subject.user_course, @exam.user_subject.subject]
  end

  private
  def exam_params
    params.require(:exam).permit Exam::EXAM_ATTRIBUTES_PARAMS
  end

  def check_status
    if @exam.init?
      @exam.update_attributes started_at: Time.zone.now, status: :testing
    end
  end

  def find_exam
    @exam = Exam.includes(results: [:answer, question: :answers])
      .find_by id: params[:id]
    if @exam.nil?
      flash[:alert] = flash_message "not_find"
      redirect_to root_path
    end
  end
end
