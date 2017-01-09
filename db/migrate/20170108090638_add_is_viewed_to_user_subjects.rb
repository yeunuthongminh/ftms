class AddIsViewedToUserSubjects < ActiveRecord::Migration[5.0]
  def change
    add_column :user_subjects, :is_viewed, :boolean, default: false
  end
end
