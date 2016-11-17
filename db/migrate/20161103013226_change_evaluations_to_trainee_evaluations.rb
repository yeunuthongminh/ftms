class ChangeEvaluationsToTraineeEvaluations < ActiveRecord::Migration[5.0]
  def change
    drop_table :evaluations do |t|
      t.string :assessment
      t.integer :total_point
      t.float :current_rank
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end

    create_table :trainee_evaluations do |t|
      t.string :assessment
      t.integer :total_point
      t.float :current_rank
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
