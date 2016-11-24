class AddRoleTypeToUserFunction < ActiveRecord::Migration[5.0]
  def change
    add_column :user_functions, :role_type, :integer
  end
end
