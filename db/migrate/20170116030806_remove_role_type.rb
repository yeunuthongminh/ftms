class RemoveRoleType < ActiveRecord::Migration[5.0]
  def change
    remove_column :roles, :role_type
  end
end
