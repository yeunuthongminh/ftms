class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :programming_language, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :categories, :deleted_at
  end
end
