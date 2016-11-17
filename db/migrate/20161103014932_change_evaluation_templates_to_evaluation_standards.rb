class ChangeEvaluationTemplatesToEvaluationStandards < ActiveRecord::Migration[5.0]
  def change
    drop_table :evaluation_templates do |t|
      t.string :name
      t.integer :min_point
      t.integer :max_point

      t.timestamps null: false
    end

    create_table :evaluation_standards do |t|
      t.string :name
      t.integer :min_point
      t.integer :max_point

      t.timestamps null: false
    end
  end
end
