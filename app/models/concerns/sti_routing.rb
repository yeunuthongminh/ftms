module StiRouting extend ActiveSupport::Concern
  included do
    class << self
      def model_name
        base_class.model_name
      end
    end
  end
end
