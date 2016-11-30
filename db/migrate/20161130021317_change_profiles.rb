class ChangeProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :div_name, :string
    change_column :profiles, :ready_for_project, :string
  end
end
