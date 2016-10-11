class AddLockForCreateExamsToUserSubjects < ActiveRecord::Migration[5.0]
  def change
    add_column :user_subjects, :lock_for_create_exam, :boolean, default: false
  end
end
