class CreateEvaluationGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluation_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
