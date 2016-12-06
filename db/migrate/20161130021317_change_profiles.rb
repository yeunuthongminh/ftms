class ChangeProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :div_name, :string
    remove_column :profiles, :ready_for_project
    add_column :profiles, :ready_for_project, :datetime
  end
end
