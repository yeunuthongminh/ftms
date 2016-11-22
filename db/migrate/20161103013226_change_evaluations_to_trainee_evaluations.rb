class ChangeEvaluationsToTraineeEvaluations < ActiveRecord::Migration[5.0]
  def change
    drop_table :evaluation_details
    drop_table :evaluation_templates
    drop_table :notes
    drop_table :evaluations

    create_table :trainee_evaluations do |t|
      t.string :targetable_type
      t.integer :targetable_id
      t.float :total_point
      t.integer :trainee_id
      t.integer :trainer_id

      t.timestamps null: false
    end

    create_table :notes do |t|
      t.string :name
      t.references :trainee_evaluation, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :author, references: :user

      t.timestamps null: false
    end
  end
end
