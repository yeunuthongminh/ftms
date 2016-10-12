class AddIndexToSubjectDetails < ActiveRecord::Migration[5.0]
  def change
    remove_index :subject_details, :subject_id
    add_index :subject_details, :subject_id, unique: true
  end
end
