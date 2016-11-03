class TrainerProgram < ApplicationRecord
  acts_as_paranoid

  before_save :restore_data

  belongs_to :user
  belongs_to :program

  private
  def restore_data
    if deleted_at_changed?
      restore recursive: true
    end
  end
end
