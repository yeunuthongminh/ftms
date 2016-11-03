class CreateTrainerPrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :trainer_programs do |t|
      t.references :user, foreign_key: true
      t.references :program, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :trainer_programs, :deleted_at
  end
end
