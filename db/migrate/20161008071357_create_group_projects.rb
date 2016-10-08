class CreateGroupProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :group_projects do |t|
      t.references :group, foreign_key: true
      t.references :project, foreign_key: true
      t.string :link_github
      t.string :link_redmine

      t.timestamps
    end
  end
end
