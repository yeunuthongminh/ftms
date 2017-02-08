class CreatePrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :programs do |t|
      t.string :name
      t.integer :program_type
      t.integer :parent_id
      t.belongs_to :organization, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
