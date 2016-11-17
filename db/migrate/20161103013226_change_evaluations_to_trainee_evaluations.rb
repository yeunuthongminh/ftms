class ChangeEvaluationsToTraineeEvaluations < ActiveRecord::Migration[5.0]
  def change
    drop_table :evaluation_details
    drop_table :evaluation_templates
    drop_table :notes
    drop_table :evaluations
    create_table :trainee_evaluations do |t|
      t.string :assessment
      t.integer :total_point
      t.float :current_rank
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
