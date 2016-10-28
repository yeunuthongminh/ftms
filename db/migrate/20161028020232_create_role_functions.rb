class CreateRoleFunctions < ActiveRecord::Migration[5.0]
  def change
    create_table :role_functions do |t|
      t.references :role, foreign_key: true
      t.references :function, foreign_key: true
    end
  end
end
