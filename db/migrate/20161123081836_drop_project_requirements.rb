class DropProjectRequirements < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :project_requirements, :projects
    remove_column :project_requirements, :name, :text
    remove_column :project_requirements, :priority, :integer

    create_table :requirements do |t|
      t.text :name
      t.integer :priority
    end

    add_reference :projects, index: true, foreign_key: true
    add_reference :requirements, index: true, foreign_key: true
  end
end
