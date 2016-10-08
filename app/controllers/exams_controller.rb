class ExamsController < ApplicationController
  before_action :find_exam, only: [:show, :update]
  authorize_resource only: [:show, :update]
  before_action :load_exams, only: :index

  def index
  end

  def show
    check_status
    @remaining_time = @exam.remaining_time
  end

  def update
    if @exam.update_attributes exam_params
      if params["finish"].nil?
        flash[:notice] = t "exams.saved"
        @exam.testing!
        redirect_to [@exam.user_subject.user_course, @exam.user_subject.subject]
      else
        flash[:success] = t "exams.finished"
        @exam.finish!
        redirect_to exams_path
      end
    else
      flash[:danger] = t "exams.update_fail"
      redirect_to [@exam.user_subject.user_course, @exam.user_subject.subject]
    end
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

  def load_exams
    @exams = current_user.exams
  end
end
