class CreateEvaluationItems < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluation_items do |t|
      t.references :evaluation_standard
      t.references :evaluation_group

      t.timestamps
    end
    add_foreign_key :evaluation_items, :evaluation_standards, index: true
    add_foreign_key :evaluation_items, :evaluation_groups, index: true
  end
end
