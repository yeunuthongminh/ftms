class ChangeEvaluationTemplatesToEvaluationStandards < ActiveRecord::Migration[5.0]
  def change
    rename_table :evaluation_templates, :evaluation_standards
    change_column :evaluation_standards, :max_point, :float
    change_column :evaluation_standards, :min_point, :float
    add_column :evaluation_standards, :average, :float
  end
end
