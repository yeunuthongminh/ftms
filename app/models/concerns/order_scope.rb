module OrderScope extend ActiveSupport::Concern
  module ClassMethods
    def order_desc column, limit = nil
      order(column => :desc).limit limit
    end
  end
end
