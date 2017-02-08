class CreateTrainingStandards < ActiveRecord::Migration[5.0]
  def change
    create_table :training_standards do |t|
      t.string :name
      t.belongs_to :program, foreign_key: true
      t.text :description
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
