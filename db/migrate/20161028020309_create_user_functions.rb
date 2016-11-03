class CreateUserFunctions < ActiveRecord::Migration[5.0]
  def change
    create_table :user_functions do |t|
      t.references :user
      t.references :function
    end
  end
end
