class AddStagesToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :stage_id, :integer
  end
end
