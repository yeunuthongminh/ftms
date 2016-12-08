class Trainer::CalendarsController < ApplicationController
  def index
    @trainees = current_user.trainees.includes :user_subjects, :courses
  end
end
