class ChangeEvaluationsToTraineeEvaluations < ActiveRecord::Migration[5.0]
  def change
    rename_table :evaluations, :trainee_evaluations
    rename_column :trainee_evaluations, :assessment, :targetable_type
    rename_column :trainee_evaluations, :total_point, :targetable_id
    rename_column :trainee_evaluations, :current_rank, :total_point
  end
end
