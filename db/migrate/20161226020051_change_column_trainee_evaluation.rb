class ChangeColumnTraineeEvaluation < ActiveRecord::Migration[5.0]
  def change
    remove_column :trainee_evaluations, :trainer_id
    rename_column :trainee_evaluations, :trainee_id, :user_id
  end
end
