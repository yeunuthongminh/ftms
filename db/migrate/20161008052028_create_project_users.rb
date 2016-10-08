class CreateProjectUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :project_users do |t|
      t.references :project, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
