class ChangeRoleTypeToTypeUserFunction < ActiveRecord::Migration[5.0]
  def change
    change_column :user_functions, :role_type, :string
    rename_column :user_functions, :role_type, :type
  end
end
