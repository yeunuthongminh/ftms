class AddParentIdToPrograms < ActiveRecord::Migration[5.0]
  def change
    add_column :programs, :parent_id, :integer
  end
end
