class CreateEvaluationStandards < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluation_standards do |t|
      t.string :name
      t.integer :min_point
      t.integer :max_point

      t.timestamps null: false
    end
  end
end
