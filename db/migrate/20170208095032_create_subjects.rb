class CreateSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :image
      t.string :description
      t.text :content
      t.belongs_to :training_standard, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
