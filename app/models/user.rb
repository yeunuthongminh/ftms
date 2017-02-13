class User < ApplicationRecord
  require_dependency "admin"
  require_dependency "trainer"
  require_dependency "trainee"

  acts_as_token_authenticatable
  acts_as_paranoid

  devise :database_authenticatable, :rememberable, :validatable

  ATTRIBUTES_PARAMS = [:email, :password]

  has_one :profile, dependent: :destroy

  has_many :moving_histories, dependent: :destroy
  has_many :organizations, dependent: :destroy
  has_many :team_members, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :user_programs, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  has_many :properties, as: :objectable, dependent: :destroy
end
