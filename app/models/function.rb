class Function < ApplicationRecord
  has_many :role_functions, dependent: :destroy
  has_many :roles, through: :role_functions

  has_many :user_functions, dependent: :destroy
  has_many :trainer_functions, class_name: TrainerFunction.name, dependent: :destroy
  has_many :trainee_functions, class_name: TraineeFunction.name, dependent: :destroy
  has_many :admin_functions, class_name: AdminFunction.name, dependent: :destroy
  has_many :users, through: :user_functions

  scope :has_function, ->controller, action{
    where "model_class = ? and action = ? ", controller, action}
end
