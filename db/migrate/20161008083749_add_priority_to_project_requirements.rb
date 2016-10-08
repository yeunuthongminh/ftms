class AddPriorityToProjectRequirements < ActiveRecord::Migration[5.0]
  def change
    add_column :project_requirements, :priority, :integer
  end
end
