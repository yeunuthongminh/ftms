class ChangeChatworkIdForUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :chatwork_id
    add_column :users, :chatwork_id, :string
  end
end
