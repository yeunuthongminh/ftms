class CreateProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :properties do |t|
      t.belongs_to :propertiable, polymorphic: true
      t.belongs_to :ownerable, polymorphic: true
      t.integer :status
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
