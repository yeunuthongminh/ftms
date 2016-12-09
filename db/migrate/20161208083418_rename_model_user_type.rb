class RenameModelUserType < ActiveRecord::Migration[5.0]
  def change
    rename_table :user_types, :trainee_types
    rename_column :profiles, :user_type_id, :trainee_type_id
    rename_column :statistics, :user_type_id, :trainee_type_id
  end
end
