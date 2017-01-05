class UserFunction < ApplicationRecord
  require_dependency "admin_function"
  require_dependency "trainer_function"
  require_dependency "trainee_function"

  belongs_to :user
  belongs_to :function

  scope :has_function, ->controller, action, type{joins(:function).
    where "functions.model_class = ? and functions.action = ?
    and type = ?", controller, action, type}
end
