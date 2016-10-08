class CreateProjectStages < ActiveRecord::Migration[5.0]
  def change
    create_table :project_stages do |t|
      t.string :name

      t.timestamps
    end
  end
end
