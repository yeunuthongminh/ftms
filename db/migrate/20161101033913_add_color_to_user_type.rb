class AddColorToUserType < ActiveRecord::Migration[5.0]
  def change
    add_column :user_types, :color, :string
  end
end
