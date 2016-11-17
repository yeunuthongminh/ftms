class CreateEvaluationCheckLists < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluation_check_lists do |t|
      t.string :name
      t.integer :point
      t.references :trainee_evaluation, index: true, foreign_key: true
      t.references :evaluation_standard, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
