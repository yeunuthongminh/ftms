class AddCurrentRoleTypeToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :current_role_type, :integer
  end
end
