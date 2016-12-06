class UserFunction < ApplicationRecord
  belongs_to :user
  belongs_to :function

  scope :has_function, ->controller, action, role{joins(:function).
    where"functions.model_class = ? and functions.action = ? 
    and role_type = ?", controller, action, role}
end
