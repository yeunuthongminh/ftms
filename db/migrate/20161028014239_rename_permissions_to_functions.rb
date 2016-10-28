class RenamePermissionsToFunctions < ActiveRecord::Migration[5.0]
  def change
    remove_reference :permissions, :role, foreign_key: true
    rename_table :permissions, :functions
  end
end
