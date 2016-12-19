class AddNameToEvaluationCheckLists < ActiveRecord::Migration[5.0]
  def change
    add_column :evaluation_check_lists, :name, :string
    add_column :evaluation_check_lists, :use, :boolean, default: false
  end
end
