class ChangeEvaluationDetailsToEvaluationCheckLists < ActiveRecord::Migration[5.0]
  def change
    rename_table :evaluation_details, :evaluation_check_lists
    rename_column :evaluation_check_lists, :evaluation_template_id,
      :evaluation_criteria_id
    rename_column :evaluation_check_lists, :point, :score
    change_column :evaluation_check_lists, :score, :float
    remove_column :evaluation_check_lists, :name
    add_reference :evaluation_check_lists, :user, index: true, foreign_key: true
  end
end
