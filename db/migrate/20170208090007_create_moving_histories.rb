class CreateMovingHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :moving_histories do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :sourceable, polymorphic: true
      t.belongs_to :destinationable, polymorphic: true,
        index: {name: "index_moving_histories_on_destinationable"}
      t.date :move_date
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
