class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.integer :parent_id
      t.belongs_to :user, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
