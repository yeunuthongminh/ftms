class UserFunction < ApplicationRecord
  require_dependency "admin_function"
  require_dependency "trainer_function"
  require_dependency "trainee_function"

  belongs_to :user
  belongs_to :function
end
