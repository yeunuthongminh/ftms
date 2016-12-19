class CreateEvaluationItems < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluation_items do |t|
      t.references :evaluation_standard, foreign_key: true, index: true
      t.references :evaluation_template, foreign_key: true, index: true

      t.timestamps
    end
  end
end
