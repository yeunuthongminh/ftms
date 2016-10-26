class AddColumnToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :deleted_at, :datetime
    add_index :projects, :deleted_at
    add_column :project_requirements, :deleted_at, :datetime
    add_index :project_requirements, :deleted_at
  end
end
