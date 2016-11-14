class ChangeEvaluationTemplatesToEvaluationCriterias < ActiveRecord::Migration[5.0]
  def change
    rename_table :evaluation_templates, :evaluation_criterias
    change_column :evaluation_criterias, :max_point, :float
    change_column :evaluation_criterias, :min_point, :float
    add_column :evaluation_criterias, :average, :float
  end
end
