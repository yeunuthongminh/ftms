class ChangeColumnNameProjectRequirements < ActiveRecord::Migration[5.0]
  def change
    change_column :project_requirements, :name, :text
  end
end
