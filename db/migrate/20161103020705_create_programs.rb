class CreatePrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :programs do |t|
      t.string :name
      t.integer :program_type
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :programs, :deleted_at
  end
end
