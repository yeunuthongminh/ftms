module LoadUser extend ActiveSupport::Concern
  included do
    def load_trainees
      User.where id: user_courses.trainee.pluck(:user_id)
    end

    def load_trainers
      User.where id: user_courses.trainer.pluck(:user_id)
    end
  end
end
