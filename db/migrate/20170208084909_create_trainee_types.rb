class CreateTraineeTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :trainee_types do |t|
      t.string :name
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
