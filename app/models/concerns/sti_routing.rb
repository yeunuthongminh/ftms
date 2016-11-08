module StiRouting extend ActiveSupport::Concern
  module ClassMethods
    def model_name
      base_class.model_name
    end
  end
end
