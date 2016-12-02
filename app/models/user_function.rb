class UserFunction < ApplicationRecord
  belongs_to :user
  belongs_to :function
  scope :has_function, ->(controller, action){joins(:function).where("functions.model_class = ?
    and functions.action = ?", controller, action)}
end
