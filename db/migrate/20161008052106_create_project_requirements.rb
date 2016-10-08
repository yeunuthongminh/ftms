class CreateProjectRequirements < ActiveRecord::Migration[5.0]
  def change
    create_table :project_requirements do |t|
      t.references :project, foreign_key: true
      t.references :project_stage, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
