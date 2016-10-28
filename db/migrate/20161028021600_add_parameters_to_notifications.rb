class AddParametersToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :parameters, :string
  end
end
