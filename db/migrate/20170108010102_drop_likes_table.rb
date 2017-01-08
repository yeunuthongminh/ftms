class DropLikesTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :likes, if_exists: true
  end

  def down
    puts "Action cannot be reverted!"
  end
end
