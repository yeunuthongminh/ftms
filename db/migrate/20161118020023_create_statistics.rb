class CreateStatistics < ActiveRecord::Migration[5.0]
  def change
    create_table :statistics do |t|
      t.date :month
      t.references :location, foreign_key: true
      t.references :stage, foreign_key: true
      t.references :user_type, foreign_key: true
      t.references :programming_language, foreign_key: true
      t.integer :total_trainee, default: 0

      t.timestamps
    end
  end
end
