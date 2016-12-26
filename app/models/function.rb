class Function < ApplicationRecord
  has_many :role_functions, dependent: :destroy
  has_many :roles, through: :role_functions

  has_many :user_functions, dependent: :destroy
  has_many :trainer_functions, dependent: :destroy
  has_many :trainee_functions, dependent: :destroy
  has_many :admin_functions, dependent: :destroy
  has_many :users, through: :user_functions

  scope :has_function, ->controller, action{
    where "model_class = ? and action = ? ", controller, action}
end
