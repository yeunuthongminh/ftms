class CreateEvaluationStandards < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluation_standards do |t|
      t.string :name
      t.float :min_point
      t.float :max_point
      t.float :avarage

      t.timestamps null: false
    end
  end
end
