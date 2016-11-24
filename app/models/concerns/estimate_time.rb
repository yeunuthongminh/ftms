module EstimateTime extend ActiveSupport::Concern
  included do
    def estimate_end_date during_time
      self.start_date ||= Time.now
      during_time.business_days.after self.start_date
    end
  end
end
