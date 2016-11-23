module TraineeRelation extend ActiveSupport::Concern
  included do
    def trainee
     super || User.find_by(id: self.user_id)
    end
  end
end
