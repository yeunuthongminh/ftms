class AddStatusToGroupUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :group_users, :deleted_at, :datetime
    add_index :group_users, :deleted_at
    add_column :groups, :deleted_at, :datetime
    add_index :groups, :deleted_at
    add_column :projects, :deleted_at, :datetime
    add_index :projects, :deleted_at
    add_column :project_stages, :deleted_at, :datetime
    add_index :project_stages, :deleted_at
    add_column :project_requirements, :deleted_at, :datetime
    add_index :project_requirements, :deleted_at
    add_column :group_projects, :deleted_at, :datetime
    add_index :group_projects, :deleted_at
  end
end
