class Team < ApplicationRecord
  acts_as_paranoid

  has_many :course_subject_teams, dependent: :destroy
  has_many :team_members, dependent: :destroy
end
