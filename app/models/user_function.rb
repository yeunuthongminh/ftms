class UserFunction < ApplicationRecord
  belongs_to :user
  belongs_to :function
  scope :has_user_function, ->controller, action, role_type{
    joins(:function).where("function.model_class = ? and function.action = ? and role_type = ?",
    controller, action, role_type)}
end
